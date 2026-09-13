import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import '../models/timeline_overview_response_model.dart';

abstract class ProjectDashboardRemoteDataSource {
  Future<TimelineOverviewResponseModel> getTimelineOverview(String projectId);
}

class ProjectDashboardRemoteDataSourceImpl implements ProjectDashboardRemoteDataSource {
  final ApiConsumer apiConsumer;

  const ProjectDashboardRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<TimelineOverviewResponseModel> getTimelineOverview(String projectId) async {
    final response = await apiConsumer.get(EndPoints.timelineOverview(projectId));
    return TimelineOverviewResponseModel.fromJson(response as Map<String, dynamic>);
  }
}
