import 'package:dartz/dartz.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/features/copilot/data/models/chat_session_summary_dto.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';
import 'package:watad/features/copilot/data/models/copilot_chat_response_dto.dart';
import 'package:watad/features/copilot/domain/repositories/copilot_repository.dart';

class CopilotUseCases {
  final CopilotRepository repository;

  CopilotUseCases({required this.repository});

  Future<Either<Failure, List<ChatSessionSummaryDto>>> getSessions(String projectId) {
    return repository.getSessions(projectId);
  }

  Future<Either<Failure, List<ChatMessageDto>>> getSessionMessages(String projectId, String sessionId) {
    return repository.getSessionMessages(projectId, sessionId);
  }

  Future<Either<Failure, Stream<String>>> askCopilotStream(String projectId, String question, {String? sessionId}) {
    return repository.askCopilotStream(projectId, question, sessionId: sessionId);
  }

  Future<Either<Failure, CopilotChatResponseDto>> askCopilotFallback(String projectId, String question, {String? sessionId}) {
    return repository.askCopilotFallback(projectId, question, sessionId: sessionId);
  }

  Future<void> initSignalR() {
    return repository.initSignalR();
  }

  Future<void> stopSignalR() {
    return repository.stopSignalR();
  }
}
