import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';

class MilestoneLogItemModel extends MilestoneLogItemEntity {
  const MilestoneLogItemModel({
    required super.id,
    required super.type,
    required super.title,
    required super.authorName,
    required super.authorRole,
    required super.timeFormatted,
    required super.description,
    super.thumbnail,
    super.attachedImages,
    super.aiConfidence,
    super.milestoneProgressPercent,
    super.isWarning,
  });

  factory MilestoneLogItemModel.fromJson(Map<String, dynamic> json) {
    MilestoneLogType parseType(String? typeStr) {
      switch (typeStr?.toLowerCase()) {
        case 'qaqc':
        case 'qa_qc':
        case 'inspection':
          return MilestoneLogType.qaQc;
        case 'safety':
        case 'warning':
          return MilestoneLogType.safety;
        case 'system':
        case 'milestone':
          return MilestoneLogType.system;
        case 'dailylog':
        case 'daily_log':
        default:
          return MilestoneLogType.dailyLog;
      }
    }

    return MilestoneLogItemModel(
      id: json['id']?.toString() ?? '',
      type: parseType(json['type'] as String?),
      title: json['title'] as String? ?? '',
      authorName: json['authorName'] as String? ?? json['author'] as String? ?? 'Ahmed Al-Masry',
      authorRole: json['authorRole'] as String? ?? 'Site Engineer',
      timeFormatted: json['timeFormatted'] as String? ?? json['time'] as String? ?? 'Today, 09:30 AM',
      description: json['description'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? json['image'] as String?,
      attachedImages: (json['attachedImages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      aiConfidence: json['aiConfidence'] as String?,
      milestoneProgressPercent: json['milestoneProgressPercent'] as String?,
      isWarning: json['isWarning'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'authorName': authorName,
      'authorRole': authorRole,
      'timeFormatted': timeFormatted,
      'description': description,
      'thumbnail': thumbnail,
      'attachedImages': attachedImages,
      'aiConfidence': aiConfidence,
      'milestoneProgressPercent': milestoneProgressPercent,
      'isWarning': isWarning,
    };
  }
}

class MilestoneLogsHeaderModel extends MilestoneLogsHeaderEntity {
  const MilestoneLogsHeaderModel({
    required super.projectId,
    required super.projectName,
    required super.phaseName,
    required super.milestoneName,
    required super.status,
    required super.estCompletionDate,
  });

  factory MilestoneLogsHeaderModel.fromJson(Map<String, dynamic> json) {
    return MilestoneLogsHeaderModel(
      projectId: json['projectId']?.toString() ?? 'proj_1',
      projectName: json['projectName'] as String? ?? 'Modern Villa Alpha',
      phaseName: json['phaseName'] as String? ?? 'Phase 1',
      milestoneName: json['milestoneName'] as String? ?? 'Excavation & Foundation',
      status: json['status'] as String? ?? 'Active',
      estCompletionDate: json['estCompletionDate'] as String? ?? 'Nov 25, 2026',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectName': projectName,
      'phaseName': phaseName,
      'milestoneName': milestoneName,
      'status': status,
      'estCompletionDate': estCompletionDate,
    };
  }
}
