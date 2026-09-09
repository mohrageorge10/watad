class CreateContractRequestDto {
  final String projectId;
  final String contractorId;
  final num totalValue;
  final String startDate;
  final String endDate;
  final String? termsAndConditions;
  final List<CreateMilestoneItemDto> milestones;

  CreateContractRequestDto({
    required this.projectId,
    required this.contractorId,
    required this.totalValue,
    required this.startDate,
    required this.endDate,
    this.termsAndConditions,
    required this.milestones,
  });

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'contractorId': contractorId,
      'totalValue': totalValue,
      'startDate': startDate,
      'endDate': endDate,
      'termsAndConditions': termsAndConditions,
      'milestones': milestones.map((e) => e.toJson()).toList(),
    };
  }
}

class CreateMilestoneItemDto {
  final String title;
  final num costPercentage;
  final num amount;
  final String targetCompletionDate;

  CreateMilestoneItemDto({
    required this.title,
    required this.costPercentage,
    required this.amount,
    required this.targetCompletionDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'costPercentage': costPercentage,
      'amount': amount,
      'targetCompletionDate': targetCompletionDate,
    };
  }
}
