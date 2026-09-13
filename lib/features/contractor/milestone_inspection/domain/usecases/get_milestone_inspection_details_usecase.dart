import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/entities/milestone_inspection_details_entity.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/repositories/milestone_inspection_repository.dart';

class GetMilestoneInspectionDetailsUseCase {
  final MilestoneInspectionRepository repository;

  GetMilestoneInspectionDetailsUseCase(this.repository);

  Future<ApiResult<MilestoneInspectionDetailsEntity>> call({
    required String milestoneId,
  }) {
    return repository.getMilestoneInspectionDetails(milestoneId: milestoneId);
  }
}
