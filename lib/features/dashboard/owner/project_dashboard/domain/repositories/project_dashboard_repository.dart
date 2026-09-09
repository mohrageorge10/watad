import '../../domain/entities/dashboard_data.dart';

abstract class ProjectDashboardRepository {
  Future<DashboardData> getDashboardData(String projectId);
}
