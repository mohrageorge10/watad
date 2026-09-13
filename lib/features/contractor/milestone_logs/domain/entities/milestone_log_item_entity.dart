import 'package:equatable/equatable.dart';

enum MilestoneLogType { dailyLog, qaQc, safety, system }

class MilestoneLogItemEntity extends Equatable {
  final String id;
  final MilestoneLogType type;
  final String title;
  final String authorName;
  final String authorRole;
  final String timeFormatted;
  final String description;
  final String? thumbnail;
  final List<String> attachedImages;
  final String? aiConfidence;
  final String? milestoneProgressPercent;
  final bool isWarning;

  const MilestoneLogItemEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.authorName,
    required this.authorRole,
    required this.timeFormatted,
    required this.description,
    this.thumbnail,
    this.attachedImages = const [],
    this.aiConfidence,
    this.milestoneProgressPercent,
    this.isWarning = false,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        title,
        authorName,
        authorRole,
        timeFormatted,
        description,
        thumbnail,
        attachedImages,
        aiConfidence,
        milestoneProgressPercent,
        isWarning,
      ];
}

class MilestoneLogsHeaderEntity extends Equatable {
  final String projectId;
  final String projectName;
  final String phaseName;
  final String milestoneName;
  final String status;
  final String estCompletionDate;

  const MilestoneLogsHeaderEntity({
    required this.projectId,
    required this.projectName,
    required this.phaseName,
    required this.milestoneName,
    required this.status,
    required this.estCompletionDate,
  });

  @override
  List<Object?> get props => [
        projectId,
        projectName,
        phaseName,
        milestoneName,
        status,
        estCompletionDate,
      ];
}
