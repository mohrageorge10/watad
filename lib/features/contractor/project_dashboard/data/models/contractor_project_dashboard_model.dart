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
      id: json['id']?.toString() ?? json['milestoneId']?.toString() ?? '',
      title: json['title'] as String? ?? json['name'] as String? ?? '',
      status: json['status'] as String? ?? '',
      targetDate: json['targetDate']?.toString() ?? json['targetCompletionDate']?.toString() ?? '',
      nextPayment: json['nextPayment']?.toString() ?? (json['amount'] != null ? 'EGP ${json['amount']}' : ''),
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
    final logsJson = json['dailyLogs'] as List<dynamic>? ?? json['recentSiteLogs'] as List<dynamic>?;

    final id = json['projectId']?.toString() ?? json['id']?.toString() ?? '';
    final projectCode = id.length >= 8 ? 'WTD-${id.substring(0, 8).toUpperCase()}' : '';
    
    // Most of these are empty because the new API doesn't provide them, 
    // but we keep the logic just in case it's updated later.
    final city = json['city']?.toString() ?? '';
    final governorate = json['governorate']?.toString() ?? '';
    final location = [city, governorate].where((e) => e.isNotEmpty).join(', ');

    final area = json['landArea']?.toString() ?? '';
    final formattedArea = area.isNotEmpty ? '$area m²' : '';

    final floorsCount = json['floorsCount']?.toString() ?? '';
    final formattedFloors = floorsCount.isNotEmpty ? '$floorsCount Floors' : '';

    final budget = json['totalContractAmount']?.toString() ?? json['estimatedBudget']?.toString() ?? json['contractValue']?.toString() ?? '';
    final formattedBudget = budget.isNotEmpty ? 'EGP $budget' : '';

    final startDateString = json['expectedStartDate']?.toString() ?? json['createdAt']?.toString() ?? '';
    String formattedStartDate = startDateString;
    String formattedEndDate = '';
    
    if (startDateString.isNotEmpty) {
      final date = DateTime.tryParse(startDateString);
      if (date != null) {
        const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        formattedStartDate = '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
      }
    }

    final finishingInt = (json['finishingLevel'] as num?)?.toInt();
    final formattedFinishing = finishingInt == 1 ? 'Premium' : (finishingInt == 2 ? 'Standard' : (finishingInt != null ? 'Basic' : ''));
    
    final statusInt = (json['status'] as num?)?.toInt();
    final formattedStatus = statusInt == 6 ? 'Active' : (statusInt != null ? 'Status $statusInt' : '');

    return ContractorProjectDashboardModel(
      projectId: id,
      projectCode: projectCode,
      title: json['projectTitle'] as String? ?? json['title'] as String? ?? json['projectName'] as String? ?? '',
      location: location,
      imageUrl: json['imageUrl'] as String? ?? json['image'] as String? ?? '',
      status: formattedStatus,
      landArea: formattedArea,
      floors: formattedFloors,
      finishingLevel: formattedFinishing,
      contractValue: formattedBudget,
      startDate: formattedStartDate,
      endDate: formattedEndDate,
      overallProgress: (json['overallProgressPercentage'] as num?)?.toInt() ?? (json['overallProgress'] as num?)?.toInt() ?? 0,
      completedProgress: (json['completedProgress'] as num?)?.toInt() ?? 0,
      inProgressProgress: (json['inProgressProgress'] as num?)?.toInt() ?? 0,
      notStartedProgress: (json['notStartedProgress'] as num?)?.toInt() ?? 0,
      activeMilestone: milestoneJson != null
          ? ActiveMilestoneModel.fromJson(milestoneJson)
          : const ActiveMilestoneModel(
              id: '',
              title: '',
              status: '',
              targetDate: '',
              nextPayment: '',
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
