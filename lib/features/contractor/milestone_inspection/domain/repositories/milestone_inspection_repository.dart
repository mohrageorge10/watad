import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/entities/milestone_inspection_details_entity.dart';

abstract class MilestoneInspectionRepository {
  Future<ApiResult<MilestoneInspectionDetailsEntity>> getMilestoneInspectionDetails({
    required String milestoneId,
  });

  Future<ApiResult<bool>> submitMilestoneInspectionRequest({
    required String milestoneId,
    String? notes,
  });
}
