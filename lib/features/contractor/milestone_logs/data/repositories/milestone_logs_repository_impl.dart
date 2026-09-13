import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/milestone_logs/data/datasources/milestone_logs_remote_data_source.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';
import 'package:watad/features/contractor/milestone_logs/domain/repositories/milestone_logs_repository.dart';

class MilestoneLogsRepositoryImpl implements MilestoneLogsRepository {
  final MilestoneLogsRemoteDataSource remoteDataSource;

  MilestoneLogsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<MilestoneLogsHeaderEntity>> getMilestoneHeader(
    String projectId,
  ) async {
    try {
      final header = await remoteDataSource.getMilestoneHeader(projectId);
      return ApiResult.success(header);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<MilestoneLogItemEntity>>> getMilestoneLogs({
    required String projectId,
    MilestoneLogType? filterType,
  }) async {
    try {
      final logs = await remoteDataSource.getMilestoneLogs(
        projectId: projectId,
        filterType: filterType,
      );
      return ApiResult.success(logs);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<bool>> requestMilestoneInspection({
    required String projectId,
    required String milestoneId,
  }) async {
    try {
      final success = await remoteDataSource.requestMilestoneInspection(
        projectId: projectId,
        milestoneId: milestoneId,
      );
      return ApiResult.success(success);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
