import 'package:watad/core/network/api/api_result.dart';
import '../../domain/entities/dashboard_data.dart';

abstract class ProjectDashboardRepository {
  Future<ApiResult<DashboardData>> getDashboardData(String projectId);
}
