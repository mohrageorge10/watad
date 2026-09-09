import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_request.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/repositories/feasibility_repository.dart';

class CalculateFeasibilityUseCase {
  final FeasibilityRepository repository;

  const CalculateFeasibilityUseCase(this.repository);

  Future<ApiResult<FeasibilityReport>> call(FeasibilityRequest request) {
    return repository.calculateFeasibility(request);
  }
}
