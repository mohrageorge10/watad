import 'package:equatable/equatable.dart';

class ContractEntity extends Equatable {
  final String id;
  final String projectId;
  final String projectName;
  final String contractorId;
  final String contractorName;
  final String clientId;
  final String clientName;
  final String status;
  final double totalAmount;
  final int durationDays;
  final String scopeOfWork;
  final String termsAndConditions;
  final String? contractorSignature;
  final DateTime? contractorSignedAt;
  final String? clientSignature;
  final DateTime? clientSignedAt;
  final DateTime createdAt;

  const ContractEntity({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.contractorId,
    required this.contractorName,
    required this.clientId,
    required this.clientName,
    required this.status,
    required this.totalAmount,
    required this.durationDays,
    required this.scopeOfWork,
    required this.termsAndConditions,
    this.contractorSignature,
    this.contractorSignedAt,
    this.clientSignature,
    this.clientSignedAt,
    required this.createdAt,
  });

  bool get isContractorSigned => contractorSignedAt != null;
  bool get isClientSigned => clientSignedAt != null;
  bool get isFullySigned => isContractorSigned && isClientSigned;

  @override
  List<Object?> get props => [
        id,
        projectId,
        projectName,
        contractorId,
        contractorName,
        clientId,
        clientName,
        status,
        totalAmount,
        durationDays,
        scopeOfWork,
        termsAndConditions,
        contractorSignature,
        contractorSignedAt,
        clientSignature,
        clientSignedAt,
        createdAt,
      ];
}
