class SiteLogsArchiveResponseModel {
  final bool isSuccess;
  final SiteLogsArchiveData? data;
  final String message;
  final int statusCode;

  SiteLogsArchiveResponseModel({
    required this.isSuccess,
    this.data,
    required this.message,
    required this.statusCode,
  });

  factory SiteLogsArchiveResponseModel.fromJson(Map<String, dynamic> json) {
    return SiteLogsArchiveResponseModel(
      isSuccess: json['isSuccess'] as bool? ?? false,
      data: json['data'] != null
          ? SiteLogsArchiveData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String? ?? '',
      statusCode: json['statusCode'] as int? ?? 0,
    );
  }
}

class SiteLogsArchiveData {
  final int totalUploads;
  final String? lastUploadAt;
  final int aiComplianceRate;
  final int activeFixNotesCount;
  final List<SiteLogItem> logs;

  SiteLogsArchiveData({
    required this.totalUploads,
    this.lastUploadAt,
    required this.aiComplianceRate,
    required this.activeFixNotesCount,
    required this.logs,
  });

  factory SiteLogsArchiveData.fromJson(Map<String, dynamic> json) {
    return SiteLogsArchiveData(
      totalUploads: (json['totalUploads'] as num?)?.toInt() ?? 0,
      lastUploadAt: json['lastUploadAt'] as String?,
      aiComplianceRate: (json['aiComplianceRate'] as num?)?.toInt() ?? 0,
      activeFixNotesCount: (json['activeFixNotesCount'] as num?)?.toInt() ?? 0,
      logs: (json['logs'] as List<dynamic>?)
              ?.map((e) => SiteLogItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class SiteLogItem {
  final String id;
  final String title;
  final String zoneOrMilestoneTitle;
  final String primaryImageUrl;
  final int mediaCount;
  final String mediaType;
  final String aiVerificationStatus;
  final String loggedAt;

  SiteLogItem({
    required this.id,
    required this.title,
    required this.zoneOrMilestoneTitle,
    required this.primaryImageUrl,
    required this.mediaCount,
    required this.mediaType,
    required this.aiVerificationStatus,
    required this.loggedAt,
  });

  factory SiteLogItem.fromJson(Map<String, dynamic> json) {
    return SiteLogItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      zoneOrMilestoneTitle: json['zoneOrMilestoneTitle'] as String? ?? '',
      primaryImageUrl: json['primaryImageUrl'] as String? ?? '',
      mediaCount: (json['mediaCount'] as num?)?.toInt() ?? 0,
      mediaType: json['mediaType'] as String? ?? '',
      aiVerificationStatus: json['aiVerificationStatus'] as String? ?? '',
      loggedAt: json['loggedAt'] as String? ?? '',
    );
  }
}
