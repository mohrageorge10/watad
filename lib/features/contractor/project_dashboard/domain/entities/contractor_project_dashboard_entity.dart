import 'package:equatable/equatable.dart';

class DailyLogEntity extends Equatable {
  final String id;
  final String imageUrl;
  final bool isAiVerified;
  final DateTime createdAt;

  const DailyLogEntity({
    required this.id,
    required this.imageUrl,
    required this.isAiVerified,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, imageUrl, isAiVerified, createdAt];
}

class ActiveMilestoneEntity extends Equatable {
  final String id;
  final String title;
  final String status;
  final String targetDate;
  final String nextPayment;

  const ActiveMilestoneEntity({
    required this.id,
    required this.title,
    required this.status,
    required this.targetDate,
    required this.nextPayment,
  });

  @override
  List<Object?> get props => [id, title, status, targetDate, nextPayment];
}

class ContractorProjectDashboardEntity extends Equatable {
  final String projectId;
  final String projectCode;
  final String title;
  final String location;
  final String imageUrl;
  final String status;
  final String landArea;
  final String floors;
  final String finishingLevel;
  final String contractValue;
  final String startDate;
  final String endDate;
  final int overallProgress;
  final int completedProgress;
  final int inProgressProgress;
  final int notStartedProgress;
  final ActiveMilestoneEntity activeMilestone;
  final List<DailyLogEntity> dailyLogs;

  const ContractorProjectDashboardEntity({
    required this.projectId,
    required this.projectCode,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.status,
    required this.landArea,
    required this.floors,
    required this.finishingLevel,
    required this.contractValue,
    required this.startDate,
    required this.endDate,
    required this.overallProgress,
    required this.completedProgress,
    required this.inProgressProgress,
    required this.notStartedProgress,
    required this.activeMilestone,
    required this.dailyLogs,
  });

  @override
  List<Object?> get props => [
        projectId,
        projectCode,
        title,
        location,
        imageUrl,
        status,
        landArea,
        floors,
        finishingLevel,
        contractValue,
        startDate,
        endDate,
        overallProgress,
        completedProgress,
        inProgressProgress,
        notStartedProgress,
        activeMilestone,
        dailyLogs,
      ];
}
