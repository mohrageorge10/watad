import 'package:flutter/material.dart';

enum ActivityStatus { verified, issue }

class ActivityFeedItem {
  final String title;
  final String time;
  final ActivityStatus status;

  ActivityFeedItem({
    required this.title,
    required this.time,
    required this.status,
  });
}

class QuickAccessItem {
  final String title;
  final IconData iconData;
  final int notificationCount;

  QuickAccessItem({
    required this.title,
    required this.iconData,
    this.notificationCount = 0,
  });
}

class ConstructionProgress {
  final int overallPercentage;
  final int elapsedPercentage;
  final String currentStage;
  final String stageStatus;
  final int daysToFinish;

  ConstructionProgress({
    required this.overallPercentage,
    required this.elapsedPercentage,
    required this.currentStage,
    required this.stageStatus,
    required this.daysToFinish,
  });
}

class MilestoneItem {
  final String id;
  final String title;
  final String targetCompletionDate;
  final String status;

  MilestoneItem({
    required this.id,
    required this.title,
    required this.targetCompletionDate,
    required this.status,
  });

  factory MilestoneItem.fromJson(Map<String, dynamic> json) {
    return MilestoneItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      targetCompletionDate: json['targetCompletionDate'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );
  }
}

class DashboardData {
  final String projectName;
  final ConstructionProgress progress;
  final List<QuickAccessItem> quickAccessItems;
  final List<MilestoneItem> milestones;

  DashboardData({
    required this.projectName,
    required this.progress,
    required this.quickAccessItems,
    required this.milestones,
  });
}
