import 'package:dartz/dartz.dart';
import 'package:watad/core/errors/exceptions.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/features/copilot/data/datasources/copilot_api_service.dart';
import 'package:watad/features/copilot/data/datasources/copilot_signalr_service.dart';
import 'package:watad/features/copilot/data/models/chat_session_summary_dto.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';
import 'package:watad/features/copilot/data/models/copilot_chat_response_dto.dart';
import 'package:watad/features/copilot/domain/repositories/copilot_repository.dart';

class CopilotRepositoryImpl implements CopilotRepository {
  final CopilotApiService apiService;
  final CopilotSignalRService signalRService;

  CopilotRepositoryImpl({
    required this.apiService,
    required this.signalRService,
  });

  @override
  Future<Either<Failure, List<ChatSessionSummaryDto>>> getSessions(String projectId) async {
    try {
      final sessions = await apiService.getSessions(projectId);
      return Right(sessions);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageDto>>> getSessionMessages(String projectId, String sessionId) async {
    try {
      final messages = await apiService.getSessionMessages(projectId, sessionId);
      return Right(messages);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<String>>> askCopilotStream(String projectId, String question, {String? sessionId}) async {
    try {
      if (!signalRService.isConnected) {
        await signalRService.initConnection();
      }
      final stream = signalRService.askCopilotStream(projectId, question, sessionId: sessionId);
      return Right(stream);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CopilotChatResponseDto>> askCopilotFallback(String projectId, String question, {String? sessionId}) async {
    try {
      final response = await apiService.askCopilotFallback(projectId, question, sessionId: sessionId);
      return Right(response);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(errMessage: e.errorModel.errorMessage));
      }
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<void> initSignalR() async {
    await signalRService.initConnection();
  }

  @override
  Future<void> stopSignalR() async {
    await signalRService.stopConnection();
  }
}
