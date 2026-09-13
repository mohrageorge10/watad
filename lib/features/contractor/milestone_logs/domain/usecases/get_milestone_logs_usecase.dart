import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';
import 'package:watad/features/contractor/milestone_logs/domain/repositories/milestone_logs_repository.dart';

class GetMilestoneLogsUseCase {
  final MilestoneLogsRepository repository;

  GetMilestoneLogsUseCase(this.repository);

  Future<ApiResult<List<MilestoneLogItemEntity>>> call({
    required String projectId,
    MilestoneLogType? filterType,
  }) async {
    return await repository.getMilestoneLogs(
      projectId: projectId,
      filterType: filterType,
    );
  }

  Future<ApiResult<MilestoneLogsHeaderEntity>> getHeader(
    String projectId,
  ) async {
    return await repository.getMilestoneHeader(projectId);
  }
}
