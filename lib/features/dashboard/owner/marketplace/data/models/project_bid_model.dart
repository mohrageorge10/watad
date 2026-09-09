import 'package:watad/features/dashboard/owner/marketplace/domain/entities/project_bid.dart';

class ProjectBidModel extends ProjectBid {
  const ProjectBidModel({
    required super.id,
    required super.contractorName,
    required super.contractorImageUrl,
    required super.date,
    required super.amount,
    required super.durationDays,
    required super.status,
  });

  factory ProjectBidModel.fromJson(Map<String, dynamic> json) {
    return ProjectBidModel(
      id: json['id']?.toString() ?? '',
      contractorName: json['contractorFullName'] ?? '',
      contractorImageUrl: json['contractorImageUrl'] ?? '',
      date: json['submittedAt'] ?? '',
      amount: (json['proposedCost'] as num?)?.toDouble() ?? 0.0,
      durationDays: (json['proposedDurationDays'] as num?)?.toInt() ?? 0,
      status: json['status']?.toString() ?? '0',
    );
  }
}
