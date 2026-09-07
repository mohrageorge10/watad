import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_request.dart';

abstract class FeasibilityRepository {
  Future<ApiResult<FeasibilityReport>> calculateFeasibility(FeasibilityRequest request);
  Future<ApiResult<void>> saveFeasibility(String reportId, String newProjectTitle);
}
