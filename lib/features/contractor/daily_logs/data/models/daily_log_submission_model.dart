import 'package:watad/features/contractor/daily_logs/domain/entities/daily_log_submission_entity.dart';

class DailyLogSubmissionModel extends DailyLogSubmissionEntity {
  const DailyLogSubmissionModel({
    required super.projectId,
    required super.projectName,
    required super.milestoneName,
    required super.location,
    required super.logDate,
    required super.mediaPaths,
    required super.isAiScanned,
    required super.aiScanResult,
    required super.workSummary,
    required super.equipmentUsed,
    required super.workersCount,
    required super.locationCoords,
    required super.timestamp,
  });

  factory DailyLogSubmissionModel.fromJson(Map<String, dynamic> json) {
    return DailyLogSubmissionModel(
      projectId: json['projectId']?.toString() ?? '',
      projectName: json['projectName'] as String? ?? 'Modern Villa Alpha',
      milestoneName: json['milestoneName'] as String? ?? 'Structural Work · Milestone 2',
      location: json['location'] as String? ?? 'New Cairo, Cairo',
      logDate: json['logDate'] != null
          ? DateTime.tryParse(json['logDate'].toString()) ?? DateTime.now()
          : DateTime.now(),
      mediaPaths: (json['mediaPaths'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isAiScanned: json['isAiScanned'] as bool? ?? false,
      aiScanResult: json['aiScanResult'] as String? ?? '',
      workSummary: json['workSummary'] as String? ?? '',
      equipmentUsed: json['equipmentUsed'] as String? ?? '',
      workersCount: (json['workersCount'] as num?)?.toInt() ?? 0,
      locationCoords: json['locationCoords'] as String? ?? '30.0131° N, 31.4989° E',
      timestamp: json['timestamp'] as String? ?? 'Sep 09, 2026 • 09:30 AM',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'projectName': projectName,
      'milestoneName': milestoneName,
      'location': location,
      'logDate': logDate.toIso8601String(),
      'mediaPaths': mediaPaths,
      'isAiScanned': isAiScanned,
      'aiScanResult': aiScanResult,
      'workSummary': workSummary,
      'equipmentUsed': equipmentUsed,
      'workersCount': workersCount,
      'locationCoords': locationCoords,
      'timestamp': timestamp,
    };
  }
}
