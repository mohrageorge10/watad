import 'package:watad/core/network/api/api_result.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/project_dashboard_repository.dart';

class GetProjectDashboardUseCase {
  final ProjectDashboardRepository repository;

  const GetProjectDashboardUseCase(this.repository);

  Future<ApiResult<DashboardData>> call(String projectId) {
    return repository.getDashboardData(projectId);
  }
}
