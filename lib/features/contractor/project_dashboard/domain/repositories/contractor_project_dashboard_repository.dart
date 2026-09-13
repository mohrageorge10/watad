import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/project_dashboard/domain/entities/contractor_project_dashboard_entity.dart';

abstract class ContractorProjectDashboardRepository {
  Future<ApiResult<ContractorProjectDashboardEntity>> getProjectDashboard(
    String projectId,
  );
}
