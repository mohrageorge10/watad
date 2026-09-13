import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/copilot/domain/usecases/copilot_usecases.dart';
import 'package:watad/features/copilot/presentation/cubit/copilot_state.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';

import 'package:watad/features/dashboard/owner/home/domain/usecases/get_current_project_overview_usecase.dart';

class CopilotCubit extends Cubit<CopilotState> {
  final CopilotUseCases useCases;
  final GetCurrentProjectOverviewUseCase getCurrentProjectOverviewUseCase;
  
  List<ChatMessageDto> _currentMessages = [];
  String? _currentSessionId;
  String _currentProjectId = '';

  CopilotCubit({
    required this.useCases,
    required this.getCurrentProjectOverviewUseCase,
  }) : super(CopilotInitial());

  Future<void> init(String? projectId) async {
    String? resolvedProjectId = projectId;
    
    // Fallback to active project if none is provided or if it's the old hardcoded test ID
    if (resolvedProjectId == null || 
        resolvedProjectId.isEmpty || 
        resolvedProjectId == '97311401-4029-43c3-88f4-d3bacf686a1e') {
      final overviewResult = await getCurrentProjectOverviewUseCase();
      overviewResult.fold(
        (data) {
          if (data.hasActiveProject && data.projectId != null) {
            resolvedProjectId = data.projectId;
          }
        },
        (failure) {},
      );
    }
    
    _currentProjectId = resolvedProjectId ?? '';
    
    if (_currentProjectId.isNotEmpty) {
      await useCases.initSignalR();
      await loadSessions(_currentProjectId);
    }
  }

  Future<void> loadSessions(String projectId) async {
    emit(CopilotSessionsLoading());
    final result = await useCases.getSessions(projectId);
    result.fold(
      (failure) => emit(CopilotSessionsError(message: failure.errMessage)),
      (sessions) => emit(CopilotSessionsLoaded(sessions: sessions)),
    );
  }

  Future<void> loadSessionMessages(String sessionId) async {
    _currentSessionId = sessionId;
    emit(CopilotMessagesLoading());
    final result = await useCases.getSessionMessages(_currentProjectId, sessionId);
    result.fold(
      (failure) => emit(CopilotMessagesError(message: failure.errMessage)),
      (messages) {
        _currentMessages = List.from(messages);
        emit(CopilotMessagesLoaded(messages: _currentMessages));
      },
    );
  }

  void startNewSession() {
    _currentSessionId = null;
    _currentMessages = [];
    emit(CopilotMessagesLoaded(messages: _currentMessages));
  }

  Future<void> askQuestion(String question) async {
    // 1. Push user message
    final userMsg = ChatMessageDto(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: 'user',
      content: question,
      createdOn: DateTime.now(),
    );
    
    // 2. Push empty assistant placeholder
    final assistantMsgId = (DateTime.now().millisecondsSinceEpoch + 1).toString();
    var assistantMsg = ChatMessageDto(
      id: assistantMsgId,
      sender: 'assistant',
      content: '',
      createdOn: DateTime.now(),
    );

    _currentMessages.add(userMsg);
    _currentMessages.add(assistantMsg);
    
    emit(CopilotMessagesLoaded(messages: List.from(_currentMessages), isStreaming: true));

    // 3. Try streaming
    try {
      final streamResult = await useCases
          .askCopilotStream(_currentProjectId, question, sessionId: _currentSessionId)
          .timeout(const Duration(seconds: 15));
      
      streamResult.fold(
        (failure) {
          // Stream initiation failed, fallback immediately
          _fallbackToRestAPI(question, assistantMsgId);
        },
        (stream) {
          String accumulatedContent = '';
          StreamSubscription<String>? subscription;
          
          subscription = stream.listen(
            (chunk) {
              accumulatedContent += chunk;
              _updateAssistantMessage(assistantMsgId, accumulatedContent);
            },
            onError: (error) {
              subscription?.cancel();
              _fallbackToRestAPI(question, assistantMsgId);
            },
            onDone: () {
              emit(CopilotMessagesLoaded(messages: List.from(_currentMessages), isStreaming: false));
            },
          );
        }
      );
    } catch (_) {
      // Timeout or other unexpected error during SignalR initiation
      _fallbackToRestAPI(question, assistantMsgId);
    }
  }

  void _updateAssistantMessage(String msgId, String content, {String? sourcesJson}) {
    final index = _currentMessages.indexWhere((msg) => msg.id == msgId);
    if (index != -1) {
      final oldMsg = _currentMessages[index];
      _currentMessages[index] = ChatMessageDto(
        id: oldMsg.id,
        sender: oldMsg.sender,
        content: content,
        sourcesJson: sourcesJson ?? oldMsg.sourcesJson,
        createdOn: oldMsg.createdOn,
      );
      emit(CopilotMessagesLoaded(messages: List.from(_currentMessages), isStreaming: true));
    }
  }

  Future<void> _fallbackToRestAPI(String question, String assistantMsgId) async {
    try {
      final fallbackResult = await useCases
          .askCopilotFallback(_currentProjectId, question, sessionId: _currentSessionId)
          .timeout(const Duration(seconds: 30));
      
      fallbackResult.fold(
        (failure) {
          _updateAssistantMessage(assistantMsgId, "Error: ${failure.errMessage}");
          emit(CopilotMessagesLoaded(messages: List.from(_currentMessages), isStreaming: false));
        },
        (response) {
          _updateAssistantMessage(
            assistantMsgId, 
            response.answer, 
            // convert sources to json string if needed
            sourcesJson: response.sources.toString() 
          );
          emit(CopilotMessagesLoaded(messages: List.from(_currentMessages), isStreaming: false));
        }
      );
    } catch (_) {
      _updateAssistantMessage(assistantMsgId, "Error: Connection timed out. Please try again later.");
      emit(CopilotMessagesLoaded(messages: List.from(_currentMessages), isStreaming: false));
    }
  }

  @override
  Future<void> close() {
    useCases.stopSignalR();
    return super.close();
  }
}
