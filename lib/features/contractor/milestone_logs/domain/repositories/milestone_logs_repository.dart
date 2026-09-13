import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';

abstract class MilestoneLogsRepository {
  Future<ApiResult<MilestoneLogsHeaderEntity>> getMilestoneHeader(String projectId);

  Future<ApiResult<List<MilestoneLogItemEntity>>> getMilestoneLogs({
    required String projectId,
    MilestoneLogType? filterType,
  });

  Future<ApiResult<bool>> requestMilestoneInspection({
    required String projectId,
    required String milestoneId,
  });
}
