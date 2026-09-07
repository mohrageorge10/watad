import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/repositories/feasibility_repository.dart';

class SaveFeasibilityUseCase {
  final FeasibilityRepository repository;

  SaveFeasibilityUseCase(this.repository);

  Future<ApiResult<void>> call(String reportId, String newProjectTitle) async {
    return await repository.saveFeasibility(reportId, newProjectTitle);
  }
}
