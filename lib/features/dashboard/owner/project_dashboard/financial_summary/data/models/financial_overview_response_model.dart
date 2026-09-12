class FinancialOverviewResponseModel {
  final bool isSuccess;
  final FinancialOverviewData? data;
  final String message;
  final int statusCode;

  FinancialOverviewResponseModel({
    required this.isSuccess,
    this.data,
    required this.message,
    required this.statusCode,
  });

  factory FinancialOverviewResponseModel.fromJson(Map<String, dynamic> json) {
    return FinancialOverviewResponseModel(
      isSuccess: json['isSuccess'] as bool? ?? false,
      data: json['data'] != null
          ? FinancialOverviewData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String? ?? '',
      statusCode: json['statusCode'] as int? ?? 0,
    );
  }
}

class FinancialOverviewData {
  final String projectId;
  final int totalContractAmount;
  final int totalPaidAmount;
  final int totalPendingAmount;
  final int remainingAmount;
  final int remainingPercentage;
  final int pendingPercentage;
  final int paidPercentage;
  final List<PaymentMilestoneModel> paymentMilestones;

  FinancialOverviewData({
    required this.projectId,
    required this.totalContractAmount,
    required this.totalPaidAmount,
    required this.totalPendingAmount,
    required this.remainingAmount,
    required this.remainingPercentage,
    required this.pendingPercentage,
    required this.paidPercentage,
    required this.paymentMilestones,
  });

  factory FinancialOverviewData.fromJson(Map<String, dynamic> json) {
    return FinancialOverviewData(
      projectId: json['projectId'] as String? ?? '',
      totalContractAmount: (json['totalContractAmount'] as num?)?.toInt() ?? 0,
      totalPaidAmount: (json['totalPaidAmount'] as num?)?.toInt() ?? 0,
      totalPendingAmount: (json['totalPendingAmount'] as num?)?.toInt() ?? 0,
      remainingAmount: (json['remainingAmount'] as num?)?.toInt() ?? 0,
      remainingPercentage: (json['remainingPercentage'] as num?)?.toInt() ?? 0,
      pendingPercentage: (json['pendingPercentage'] as num?)?.toInt() ?? 0,
      paidPercentage: (json['paidPercentage'] as num?)?.toInt() ?? 0,
      paymentMilestones: (json['paymentMilestones'] as List<dynamic>?)
              ?.map((e) =>
                  PaymentMilestoneModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class PaymentMilestoneModel {
  final String milestoneId;
  final String title;
  final int amount;
  final String targetCompletionDate;
  final String paymentStatus;

  PaymentMilestoneModel({
    required this.milestoneId,
    required this.title,
    required this.amount,
    required this.targetCompletionDate,
    required this.paymentStatus,
  });

  factory PaymentMilestoneModel.fromJson(Map<String, dynamic> json) {
    return PaymentMilestoneModel(
      milestoneId: json['milestoneId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      amount: (json['amount'] as num?)?.toInt() ?? 0,
      targetCompletionDate:
          (json['targetCompletionDate'] as String? ?? '').split('T').first,
      paymentStatus: json['paymentStatus'] as String? ?? '',
    );
  }
}
