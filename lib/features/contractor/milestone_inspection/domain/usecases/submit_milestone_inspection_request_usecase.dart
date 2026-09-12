import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/repositories/milestone_inspection_repository.dart';

class SubmitMilestoneInspectionRequestUseCase {
  final MilestoneInspectionRepository repository;

  SubmitMilestoneInspectionRequestUseCase(this.repository);

  Future<ApiResult<bool>> call({
    required String milestoneId,
    String? notes,
  }) {
    return repository.submitMilestoneInspectionRequest(
      milestoneId: milestoneId,
      notes: notes,
    );
  }
}
