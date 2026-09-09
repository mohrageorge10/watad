class ContractDetailsDto {
  final String id;
  final String projectId;
  final String projectTitle;
  final String? projectCity;
  final String? projectGovernorate;
  final String? ownerName;
  final String? consultantId;
  final String? consultantName;
  final num totalValue;
  final String startDate;
  final String endDate;
  final String? termsAndConditions;
  final String? contractPdfUrl;
  final String createdAt;
  final List<ContractMilestoneDto> milestones;

  ContractDetailsDto({
    required this.id,
    required this.projectId,
    required this.projectTitle,
    this.projectCity,
    this.projectGovernorate,
    this.ownerName,
    this.consultantId,
    this.consultantName,
    required this.totalValue,
    required this.startDate,
    required this.endDate,
    this.termsAndConditions,
    this.contractPdfUrl,
    required this.createdAt,
    required this.milestones,
  });

  factory ContractDetailsDto.fromJson(Map<String, dynamic> json) {
    return ContractDetailsDto(
      id: json['id'] ?? '',
      projectId: json['projectId'] ?? '',
      projectTitle: json['projectTitle'] ?? '',
      projectCity: json['projectCity'],
      projectGovernorate: json['projectGovernorate'],
      ownerName: json['ownerName'],
      consultantId: json['consultantId'],
      consultantName: json['consultantName'],
      totalValue: json['totalValue'] ?? 0.0,
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      termsAndConditions: json['termsAndConditions'],
      contractPdfUrl: json['contractPdfUrl'],
      createdAt: json['createdAt'] ?? '',
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((e) => ContractMilestoneDto.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ContractMilestoneDto {
  final String title;
  final num costPercentage;
  final num amount;
  final String targetCompletionDate;

  ContractMilestoneDto({
    required this.title,
    required this.costPercentage,
    required this.amount,
    required this.targetCompletionDate,
  });

  factory ContractMilestoneDto.fromJson(Map<String, dynamic> json) {
    return ContractMilestoneDto(
      title: json['title'] ?? '',
      costPercentage: json['costPercentage'] ?? 0.0,
      amount: json['amount'] ?? 0.0,
      targetCompletionDate: json['targetCompletionDate'] ?? '',
    );
  }
}
