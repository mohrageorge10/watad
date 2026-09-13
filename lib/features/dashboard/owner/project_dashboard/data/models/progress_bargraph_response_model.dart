class ProgressBargraphResponseModel {
  final bool isSuccess;
  final List<ProgressByStageItem>? progressByStage;
  final String message;
  final int statusCode;

  ProgressBargraphResponseModel({
    required this.isSuccess,
    this.progressByStage,
    required this.message,
    required this.statusCode,
  });

  factory ProgressBargraphResponseModel.fromJson(Map<String, dynamic> json) {
    return ProgressBargraphResponseModel(
      isSuccess: json['isSuccess'] as bool? ?? false,
      progressByStage: json['data'] != null && json['data']['progressByStage'] != null
          ? (json['data']['progressByStage'] as List<dynamic>)
              .map((e) => ProgressByStageItem.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
      message: json['message'] as String? ?? '',
      statusCode: json['statusCode'] as int? ?? 0,
    );
  }
}

class ProgressByStageItem {
  final String milestoneId;
  final String stageName;
  final int plannedProgressPercentage;
  final int actualProgressPercentage;

  ProgressByStageItem({
    required this.milestoneId,
    required this.stageName,
    required this.plannedProgressPercentage,
    required this.actualProgressPercentage,
  });

  factory ProgressByStageItem.fromJson(Map<String, dynamic> json) {
    return ProgressByStageItem(
      milestoneId: json['milestoneId'] as String? ?? '',
      stageName: json['stageName'] as String? ?? '',
      plannedProgressPercentage: (json['plannedProgressPercentage'] as num?)?.toInt() ?? 0,
      actualProgressPercentage: (json['actualProgressPercentage'] as num?)?.toInt() ?? 0,
    );
  }
}
