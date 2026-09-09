import 'package:equatable/equatable.dart';

class BidDetails extends Equatable {
  final String id;
  final String projectId;
  final String projectTitle;
  final String contractorId;
  final String contractorName;
  final String contractorPhoneNumber;
  final String contractorEmail;
  final double amount;
  final int durationDays;
  final String technicalProposalUrl;
  final String status;
  final String submittedAt;

  const BidDetails({
    required this.id,
    required this.projectId,
    required this.projectTitle,
    required this.contractorId,
    required this.contractorName,
    required this.contractorPhoneNumber,
    required this.contractorEmail,
    required this.amount,
    required this.durationDays,
    required this.technicalProposalUrl,
    required this.status,
    required this.submittedAt,
  });

  @override
  List<Object?> get props => [
        id,
        projectId,
        projectTitle,
        contractorId,
        contractorName,
        contractorPhoneNumber,
        contractorEmail,
        amount,
        durationDays,
        technicalProposalUrl,
        status,
        submittedAt,
      ];
}
