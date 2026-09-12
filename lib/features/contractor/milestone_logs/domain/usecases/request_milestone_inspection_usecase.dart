import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/milestone_logs/domain/repositories/milestone_logs_repository.dart';

class RequestMilestoneInspectionUseCase {
  final MilestoneLogsRepository repository;

  RequestMilestoneInspectionUseCase(this.repository);

  Future<ApiResult<bool>> call({
    required String projectId,
    required String milestoneId,
  }) async {
    return await repository.requestMilestoneInspection(
      projectId: projectId,
      milestoneId: milestoneId,
    );
  }
}
