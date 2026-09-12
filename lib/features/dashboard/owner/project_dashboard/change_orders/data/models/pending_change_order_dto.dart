import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/domain/entities/change_order_details.dart';

class PendingChangeOrderDto {
  final String? id;
  final String? projectId;
  final String? requestedByUserId;
  final String? description;
  final num? costImpact;
  final int? timeImpactDays;
  final String? createdAt;
  final String? status;

  PendingChangeOrderDto({
    this.id,
    this.projectId,
    this.requestedByUserId,
    this.description,
    this.costImpact,
    this.timeImpactDays,
    this.createdAt,
    this.status,
  });

  factory PendingChangeOrderDto.fromJson(Map<String, dynamic> json) {
    return PendingChangeOrderDto(
      id: json['id'] as String?,
      projectId: json['projectId'] as String?,
      requestedByUserId: json['requestedByUserId'] as String?,
      description: json['description'] as String?,
      costImpact: (json['costImpact'] as num?)?.toDouble(),
      timeImpactDays: (json['timeImpactDays'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      status: json['status'] as String?,
    );
  }

  ChangeOrderDetails toEntity() {
    return ChangeOrderDetails(
      id: id ?? '',
      description: description ?? '',
      costImpact: costImpact ?? 0,
      timeImpactDays: timeImpactDays ?? 0,
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) ?? DateTime.now() : DateTime.now(),
      status: _mapStatus(status),
    );
  }

  ChangeOrderReviewStatus _mapStatus(String? statusStr) {
    switch (statusStr?.toLowerCase()) {
      case 'approved':
        return ChangeOrderReviewStatus.approved;
      case 'rejected':
        return ChangeOrderReviewStatus.rejected;
      case 'pending':
      default:
        return ChangeOrderReviewStatus.pending;
    }
  }
}
