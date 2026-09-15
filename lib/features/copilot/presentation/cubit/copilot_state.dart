import 'package:equatable/equatable.dart';
import 'package:watad/features/copilot/data/models/chat_session_summary_dto.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';

abstract class CopilotState extends Equatable {
  const CopilotState();

  @override
  List<Object?> get props => [];
}

class CopilotInitial extends CopilotState {}

class CopilotSessionsLoading extends CopilotState {}
class CopilotSessionsLoaded extends CopilotState {
  final List<ChatSessionSummaryDto> sessions;
  const CopilotSessionsLoaded({required this.sessions});
  @override
  List<Object?> get props => [sessions];
}
class CopilotSessionsError extends CopilotState {
  final String message;
  const CopilotSessionsError({required this.message});
  @override
  List<Object?> get props => [message];
}

class CopilotMessagesLoading extends CopilotState {}
class CopilotMessagesLoaded extends CopilotState {
  final List<ChatMessageDto> messages;
  final bool isStreaming;
  
  const CopilotMessagesLoaded({required this.messages, this.isStreaming = false});
  @override
  List<Object?> get props => [messages, isStreaming];
}
class CopilotMessagesError extends CopilotState {
  final String message;
  const CopilotMessagesError({required this.message});
  @override
  List<Object?> get props => [message];
}
