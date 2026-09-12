import 'package:watad/features/contractor/project_dashboard/domain/entities/contractor_project_dashboard_entity.dart';

class DailyLogModel extends DailyLogEntity {
  const DailyLogModel({
    required super.id,
    required super.imageUrl,
    required super.isAiVerified,
    required super.createdAt,
  });

  factory DailyLogModel.fromJson(Map<String, dynamic> json) {
    return DailyLogModel(
      id: json['id']?.toString() ?? '',
      imageUrl: json['imageUrl'] as String? ?? json['image'] as String? ?? '',
      isAiVerified: json['isAiVerified'] as bool? ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'isAiVerified': isAiVerified,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class ActiveMilestoneModel extends ActiveMilestoneEntity {
  const ActiveMilestoneModel({
    required super.id,
    required super.title,
    required super.status,
    required super.targetDate,
    required super.nextPayment,
  });

  factory ActiveMilestoneModel.fromJson(Map<String, dynamic> json) {
    return ActiveMilestoneModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? json['name'] as String? ?? 'Excavation & Foundation',
      status: json['status'] as String? ?? 'In Progress',
      targetDate: json['targetDate'] as String? ?? 'Nov 25, 2026',
      nextPayment: json['nextPayment'] as String? ?? 'EGP 350,000',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'targetDate': targetDate,
      'nextPayment': nextPayment,
    };
  }
}

class ContractorProjectDashboardModel
    extends ContractorProjectDashboardEntity {
  const ContractorProjectDashboardModel({
    required super.projectId,
    required super.projectCode,
    required super.title,
    required super.location,
    required super.imageUrl,
    required super.status,
    required super.landArea,
    required super.floors,
    required super.finishingLevel,
    required super.contractValue,
    required super.startDate,
    required super.endDate,
    required super.overallProgress,
    required super.completedProgress,
    required super.inProgressProgress,
    required super.notStartedProgress,
    required super.activeMilestone,
    required super.dailyLogs,
  });

  factory ContractorProjectDashboardModel.fromJson(Map<String, dynamic> json) {
    final milestoneJson = json['activeMilestone'] as Map<String, dynamic>?;
    final logsJson = json['dailyLogs'] as List<dynamic>?;

    return ContractorProjectDashboardModel(
      projectId: json['projectId']?.toString() ?? json['id']?.toString() ?? 'proj_1',
      projectCode: json['projectCode'] as String? ?? 'WTD-2026-089',
      title: json['title'] as String? ?? json['projectName'] as String? ?? 'Modern Villa Alpha',
      location: json['location'] as String? ?? 'New Cairo, Cairo',
      imageUrl: json['imageUrl'] as String? ?? json['image'] as String? ?? '',
      status: json['status'] as String? ?? 'Active',
      landArea: json['landArea'] as String? ?? '1,200 m²',
      floors: json['floors'] as String? ?? '2',
      finishingLevel: json['finishingLevel'] as String? ?? 'Premium',
      contractValue: json['contractValue'] as String? ?? 'EGP 2,450,000',
      startDate: json['startDate'] as String? ?? 'Nov 01, 2026',
      endDate: json['endDate'] as String? ?? 'May 01, 2027',
      overallProgress: (json['overallProgress'] as num?)?.toInt() ?? 42,
      completedProgress: (json['completedProgress'] as num?)?.toInt() ?? 42,
      inProgressProgress: (json['inProgressProgress'] as num?)?.toInt() ?? 38,
      notStartedProgress: (json['notStartedProgress'] as num?)?.toInt() ?? 20,
      activeMilestone: milestoneJson != null
          ? ActiveMilestoneModel.fromJson(milestoneJson)
          : const ActiveMilestoneModel(
              id: 'ms_1',
              title: 'Excavation & Foundation',
              status: 'In Progress',
              targetDate: 'Nov 25, 2026',
              nextPayment: 'EGP 350,000',
            ),
      dailyLogs: logsJson != null
          ? logsJson
              .map((e) => DailyLogModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectCode': projectCode,
      'title': title,
      'location': location,
      'imageUrl': imageUrl,
      'status': status,
      'landArea': landArea,
      'floors': floors,
      'finishingLevel': finishingLevel,
      'contractValue': contractValue,
      'startDate': startDate,
      'endDate': endDate,
      'overallProgress': overallProgress,
      'completedProgress': completedProgress,
      'inProgressProgress': inProgressProgress,
      'notStartedProgress': notStartedProgress,
      'activeMilestone': (activeMilestone as ActiveMilestoneModel).toJson(),
      'dailyLogs': dailyLogs.map((e) => (e as DailyLogModel).toJson()).toList(),
    };
  }
}
