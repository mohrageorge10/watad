
import 'package:watad/features/dashboard/owner/home/domain/entities/current_project_overview.dart';

class CurrentProjectOverviewModel extends CurrentProjectOverview {
  const CurrentProjectOverviewModel({
    super.projectId,
    required super.title,
    required super.status,
    required super.location,
    required super.city,
    required super.governorate,
    super.imageUrl,
    required super.overallProgressPercentage,
    super.startDate,
    super.nextMilestoneTitle,
    required super.daysElapsed,
    super.estimatedCompletionDate,
    required super.hasActiveProject,
  });

  factory CurrentProjectOverviewModel.fromJson(Map<String, dynamic> json) {
    return CurrentProjectOverviewModel(
      projectId: json['projectId'] as String?,
      title: json['title'] as String? ?? '',
      status: _mapStatus(json['status']),
      location: json['location'] as String? ?? '',
      city: json['city'] as String? ?? '',
      governorate: json['governorate'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      overallProgressPercentage:
          (json['overallProgressPercentage'] as num?) ?? 0,
      startDate: json['startDate'] != null
          ? DateTime.tryParse(json['startDate'].toString())
          : null,
      nextMilestoneTitle: json['nextMilestoneTitle'] as String?,
      daysElapsed: (json['daysElapsed'] as num?)?.toInt() ?? 0,
      estimatedCompletionDate: json['estimatedCompletionDate'] != null
          ? DateTime.tryParse(json['estimatedCompletionDate'].toString())
          : null,
      hasActiveProject: json['hasActiveProject'] as bool? ?? false,
    );
  }

  static String _mapStatus(dynamic rawStatus) {
    if (rawStatus == null) return '';
    final str = rawStatus.toString();
    if (str == '0') return 'Draft';
    if (str == '1') return 'Design Phase';
    if (str == '2') return 'In Progress';
    if (str == '3') return 'Completed';
    return str;
  }
}
