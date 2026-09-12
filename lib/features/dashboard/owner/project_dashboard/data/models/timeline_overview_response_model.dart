import '../../domain/entities/dashboard_data.dart';

class TimelineOverviewResponseModel {
  final bool isSuccess;
  final TimelineOverviewData? data;
  final String message;
  final int statusCode;

  TimelineOverviewResponseModel({
    required this.isSuccess,
    this.data,
    required this.message,
    required this.statusCode,
  });

  factory TimelineOverviewResponseModel.fromJson(Map<String, dynamic> json) {
    return TimelineOverviewResponseModel(
      isSuccess: json['isSuccess'] as bool? ?? false,
      data: json['data'] != null
          ? TimelineOverviewData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String? ?? '',
      statusCode: json['statusCode'] as int? ?? 0,
    );
  }
}

class TimelineOverviewData {
  final String projectId;
  final String projectTitle;
  final int overallPhysicalProgress;
  final int timeElapsedPercentage;
  final String currentStageName;
  final String currentStageStatus;
  final int daysUntilPlannedCompletion;
  final List<MilestoneItem> milestones;

  TimelineOverviewData({
    required this.projectId,
    required this.projectTitle,
    required this.overallPhysicalProgress,
    required this.timeElapsedPercentage,
    required this.currentStageName,
    required this.currentStageStatus,
    required this.daysUntilPlannedCompletion,
    required this.milestones,
  });

  factory TimelineOverviewData.fromJson(Map<String, dynamic> json) {
    return TimelineOverviewData(
      projectId: json['projectId'] as String? ?? '',
      projectTitle: json['projectTitle'] as String? ?? '',
      overallPhysicalProgress: (json['overallPhysicalProgress'] as num?)?.toInt() ?? 0,
      timeElapsedPercentage: (json['timeElapsedPercentage'] as num?)?.toInt() ?? 0,
      currentStageName: json['currentStageName'] as String? ?? '',
      currentStageStatus: json['currentStageStatus'] as String? ?? '',
      daysUntilPlannedCompletion:
      (json['daysUntilPlannedCompletion'] as num?)?.toInt() ?? 0,
      milestones: (json['milestones'] as List<dynamic>?)
          ?.map((e) => MilestoneItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}