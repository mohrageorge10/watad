import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/daily_logs/data/datasources/daily_logs_remote_data_source.dart';
import 'package:watad/features/contractor/daily_logs/data/models/daily_log_submission_model.dart';
import 'package:watad/features/contractor/daily_logs/domain/entities/daily_log_submission_entity.dart';
import 'package:watad/features/contractor/daily_logs/domain/repositories/daily_logs_repository.dart';

class DailyLogsRepositoryImpl implements DailyLogsRepository {
  final DailyLogsRemoteDataSource remoteDataSource;

  DailyLogsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<bool>> submitDailyLog(
    DailyLogSubmissionEntity submission,
  ) async {
    try {
      final model = DailyLogSubmissionModel(
        projectId: submission.projectId,
        projectName: submission.projectName,
        milestoneName: submission.milestoneName,
        milestoneId: submission.milestoneId,
        location: submission.location,
        logDate: submission.logDate,
        mediaPaths: submission.mediaPaths,
        isAiScanned: submission.isAiScanned,
        aiScanResult: submission.aiScanResult,
        workSummary: submission.workSummary,
        equipmentUsed: submission.equipmentUsed,
        workersCount: submission.workersCount,
        locationCoords: submission.locationCoords,
        timestamp: submission.timestamp,
      );

      final success = await remoteDataSource.submitDailyLog(model);
      return ApiResult.success(success);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
