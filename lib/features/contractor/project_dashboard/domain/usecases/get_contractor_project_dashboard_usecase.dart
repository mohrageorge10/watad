import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/project_dashboard/domain/entities/contractor_project_dashboard_entity.dart';
import 'package:watad/features/contractor/project_dashboard/domain/repositories/contractor_project_dashboard_repository.dart';

class GetContractorProjectDashboardUseCase {
  final ContractorProjectDashboardRepository repository;

  GetContractorProjectDashboardUseCase(this.repository);

  Future<ApiResult<ContractorProjectDashboardEntity>> call(
    String projectId,
  ) async {
    return await repository.getProjectDashboard(projectId);
  }
}
