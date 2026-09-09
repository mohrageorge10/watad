import 'package:watad/features/contractor/contracts/domain/entities/contract_entity.dart';

class ContractModel extends ContractEntity {
  const ContractModel({
    required super.id,
    required super.projectId,
    required super.projectName,
    required super.contractorId,
    required super.contractorName,
    required super.clientId,
    required super.clientName,
    required super.status,
    required super.totalAmount,
    required super.durationDays,
    required super.scopeOfWork,
    required super.termsAndConditions,
    super.contractorSignature,
    super.contractorSignedAt,
    super.clientSignature,
    super.clientSignedAt,
    required super.createdAt,
  });

  factory ContractModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic date) {
      if (date == null) return null;
      if (date is String && date.isNotEmpty) {
        return DateTime.tryParse(date);
      }
      return null;
    }

    double parseDouble(dynamic val) {
      if (val == null) return 0.0;
      if (val is num) return val.toDouble();
      if (val is String) {
        final clean = val.replaceAll(RegExp(r'[^0-9.]'), '');
        return double.tryParse(clean) ?? 0.0;
      }
      return 0.0;
    }

    int parseInt(dynamic val) {
      if (val == null) return 0;
      if (val is num) return val.toInt();
      if (val is String) {
        final clean = val.replaceAll(RegExp(r'[^0-9]'), '');
        return int.tryParse(clean) ?? 0;
      }
      return 0;
    }

    return ContractModel(
      id: json['id']?.toString() ?? '',
      projectId: json['projectId']?.toString() ?? '',
      projectName: json['projectName'] as String? ??
          json['projectTitle'] as String? ??
          'Construction Project',
      contractorId: json['contractorId']?.toString() ?? '',
      contractorName: json['contractorName'] as String? ?? 'Contractor',
      clientId: json['clientId']?.toString() ?? '',
      clientName: json['clientName'] as String? ?? 'Client',
      status: json['status'] as String? ?? 'Draft',
      totalAmount: parseDouble(json['totalAmount'] ?? json['amount']),
      durationDays: parseInt(json['durationDays'] ?? json['duration']),
      scopeOfWork: json['scopeOfWork'] as String? ??
          json['scope'] as String? ??
          'Standard construction and finishing works as specified in project documents.',
      termsAndConditions: json['termsAndConditions'] as String? ??
          json['terms'] as String? ??
          'All work shall comply with Egyptian construction standards and building codes.',
      contractorSignature: json['contractorSignature'] as String?,
      contractorSignedAt: parseDate(json['contractorSignedAt']),
      clientSignature: json['clientSignature'] as String?,
      clientSignedAt: parseDate(json['clientSignedAt']),
      createdAt: parseDate(json['createdAt']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'projectName': projectName,
      'contractorId': contractorId,
      'contractorName': contractorName,
      'clientId': clientId,
      'clientName': clientName,
      'status': status,
      'totalAmount': totalAmount,
      'durationDays': durationDays,
      'scopeOfWork': scopeOfWork,
      'termsAndConditions': termsAndConditions,
      'contractorSignature': contractorSignature,
      'contractorSignedAt': contractorSignedAt?.toIso8601String(),
      'clientSignature': clientSignature,
      'clientSignedAt': clientSignedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  ContractModel copyWith({
    String? id,
    String? projectId,
    String? projectName,
    String? contractorId,
    String? contractorName,
    String? clientId,
    String? clientName,
    String? status,
    double? totalAmount,
    int? durationDays,
    String? scopeOfWork,
    String? termsAndConditions,
    String? contractorSignature,
    DateTime? contractorSignedAt,
    String? clientSignature,
    DateTime? clientSignedAt,
    DateTime? createdAt,
  }) {
    return ContractModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      contractorId: contractorId ?? this.contractorId,
      contractorName: contractorName ?? this.contractorName,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      durationDays: durationDays ?? this.durationDays,
      scopeOfWork: scopeOfWork ?? this.scopeOfWork,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      contractorSignature: contractorSignature ?? this.contractorSignature,
      contractorSignedAt: contractorSignedAt ?? this.contractorSignedAt,
      clientSignature: clientSignature ?? this.clientSignature,
      clientSignedAt: clientSignedAt ?? this.clientSignedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
