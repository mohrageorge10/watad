import 'package:watad/features/dashboard/owner/home/domain/entities/project_summary.dart';

class ProjectSummaryModel extends ProjectSummary {
  const ProjectSummaryModel({
    required super.projectId,
    required super.title,
    super.imageUrl,
    required super.location,
    required super.status,
    required super.overallProgressPercentage,
    super.updatedAt,
  });

  factory ProjectSummaryModel.fromJson(Map<String, dynamic> json) {
    final dynamic rawProgress =
        json['overallProgressPercentage'] ?? json['progressPercentage'];
    final dynamic rawUpdatedAt = json['updatedAt'] ?? json['lastUpdatedAt'];

    return ProjectSummaryModel(
      projectId: (json['projectId'] ?? json['id'] ?? '').toString(),
      title: json['title'] as String? ?? '',
      imageUrl: json['imageUrl'] as String?,
      location: json['location'] as String? ??
          [json['city'], json['governorate']]
              .where((e) => e != null && e.toString().isNotEmpty)
              .join(', '),
      status: _mapStatus(json['status']),
      overallProgressPercentage: (rawProgress as num?) ?? 0,
      updatedAt:
          rawUpdatedAt != null ? DateTime.tryParse(rawUpdatedAt.toString()) : null,
    );
  }

  static String _mapStatus(dynamic rawStatus) {
    if (rawStatus == null) return '';
    final str = rawStatus.toString();
    if (str == '0') return 'Draft';
    if (str == '1') return 'Design Phase';
    if (str == '2') return 'In Progress';
    if (str == '3') return 'Completed';
    if (str == '6') return 'In Contracting';
    return str;
  }
}
