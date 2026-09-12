import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import '../../../data/models/timeline_overview_response_model.dart';
import '../../../data/models/progress_bargraph_response_model.dart';
import '../../../data/models/site_logs_archive_response_model.dart';

abstract class ProgressSiteUpdatesRemoteDataSource {
  Future<TimelineOverviewResponseModel> getTimelineOverview(String projectId);
  Future<ProgressBargraphResponseModel> getProgressBargraph(String projectId);
  Future<SiteLogsArchiveResponseModel> getSiteLogsArchive(String projectId, String milestoneId);
}

class ProgressSiteUpdatesRemoteDataSourceImpl
    implements ProgressSiteUpdatesRemoteDataSource {
  final ApiConsumer apiConsumer;

  const ProgressSiteUpdatesRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<TimelineOverviewResponseModel> getTimelineOverview(String projectId) async {
    final response = await apiConsumer.get(EndPoints.timelineOverview(projectId));
    return TimelineOverviewResponseModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<ProgressBargraphResponseModel> getProgressBargraph(String projectId) async {
    final response = await apiConsumer.get(EndPoints.progressBargraph(projectId));
    return ProgressBargraphResponseModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<SiteLogsArchiveResponseModel> getSiteLogsArchive(String projectId, String milestoneId) async {
    final response = await apiConsumer.get(
      EndPoints.siteLogsArchive(projectId),
      queryParameters: {
        'MilestoneId': milestoneId,
      },
    );
    return SiteLogsArchiveResponseModel.fromJson(response as Map<String, dynamic>);
  }
}
