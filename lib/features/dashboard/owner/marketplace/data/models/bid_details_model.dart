import 'package:watad/features/dashboard/owner/marketplace/domain/entities/bid_details.dart';

class BidDetailsModel extends BidDetails {
  const BidDetailsModel({
    required super.id,
    required super.projectId,
    required super.projectTitle,
    required super.contractorId,
    required super.contractorName,
    required super.contractorPhoneNumber,
    required super.contractorEmail,
    required super.amount,
    required super.durationDays,
    required super.technicalProposalUrl,
    required super.status,
    required super.submittedAt,
  });

  factory BidDetailsModel.fromJson(Map<String, dynamic> json) {
    return BidDetailsModel(
      id: json['id']?.toString() ?? '',
      projectId: json['projectId']?.toString() ?? '',
      projectTitle: json['projectTitle'] ?? '',
      contractorId: json['contractorId']?.toString() ?? '',
      contractorName: json['contractorFullName'] ?? '',
      contractorPhoneNumber: json['contractorPhoneNumber'] ?? '',
      contractorEmail: json['contractorEmail'] ?? '',
      amount: (json['proposedCost'] as num?)?.toDouble() ?? 0.0,
      durationDays: (json['proposedDurationDays'] as num?)?.toInt() ?? 0,
      technicalProposalUrl: json['technicalProposalUrl'] ?? '',
      status: json['status']?.toString() ?? '0',
      submittedAt: json['submittedAt'] ?? '',
    );
  }
}
