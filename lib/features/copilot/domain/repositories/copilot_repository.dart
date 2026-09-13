import 'package:dartz/dartz.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/features/copilot/data/models/chat_session_summary_dto.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';
import 'package:watad/features/copilot/data/models/copilot_chat_response_dto.dart';

abstract class CopilotRepository {
  Future<Either<Failure, List<ChatSessionSummaryDto>>> getSessions(String projectId);
  Future<Either<Failure, List<ChatMessageDto>>> getSessionMessages(String projectId, String sessionId);
  
  /// Asks the copilot using SignalR if possible, falls back to REST API otherwise.
  Future<Either<Failure, Stream<String>>> askCopilotStream(String projectId, String question, {String? sessionId});
  
  /// Forces the REST fallback directly
  Future<Either<Failure, CopilotChatResponseDto>> askCopilotFallback(String projectId, String question, {String? sessionId});
  
  Future<void> initSignalR();
  Future<void> stopSignalR();
}
