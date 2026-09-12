class ChangeOrdersHistoryResponseModel {
  final bool isSuccess;
  final List<ChangeOrderDto>? data;
  final String message;
  final int statusCode;

  ChangeOrdersHistoryResponseModel({
    required this.isSuccess,
    this.data,
    required this.message,
    required this.statusCode,
  });

  factory ChangeOrdersHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangeOrdersHistoryResponseModel(
      isSuccess: json['isSuccess'] as bool? ?? false,
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((e) => ChangeOrderDto.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      message: json['message'] as String? ?? '',
      statusCode: json['statusCode'] as int? ?? 0,
    );
  }
}

class ChangeOrderDto {
  final String id;
  final String projectId;
  final String requestedByUserId;
  final String description;
  final double costImpact;
  final int timeImpactDays;
  final String status;
  final String createdAt;
  final String? rejectionReason;
  final String? reviewedByUserId;
  final String? reviewedAt;

  ChangeOrderDto({
    required this.id,
    required this.projectId,
    required this.requestedByUserId,
    required this.description,
    required this.costImpact,
    required this.timeImpactDays,
    required this.status,
    required this.createdAt,
    this.rejectionReason,
    this.reviewedByUserId,
    this.reviewedAt,
  });

  factory ChangeOrderDto.fromJson(Map<String, dynamic> json) {
    return ChangeOrderDto(
      id: json['id'] as String? ?? '',
      projectId: json['projectId'] as String? ?? '',
      requestedByUserId: json['requestedByUserId'] as String? ?? 'Unknown',
      description: json['description'] as String? ?? '',
      costImpact: (json['costImpact'] as num?)?.toDouble() ?? 0.0,
      timeImpactDays: (json['timeImpactDays'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      rejectionReason: json['rejectionReason'] as String?,
      reviewedByUserId: json['reviewedByUserId'] as String?,
      reviewedAt: json['reviewedAt'] as String?,
    );
  }
}
