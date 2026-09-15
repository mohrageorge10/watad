import 'package:equatable/equatable.dart';

class DailyLogSubmissionEntity extends Equatable {
  final String projectId;
  final String projectName;
  final String milestoneName;
  final String milestoneId;
  final String location;
  final DateTime logDate;
  final List<String> mediaPaths;
  final bool isAiScanned;
  final String aiScanResult;
  final String workSummary;
  final String equipmentUsed;
  final int workersCount;
  final String locationCoords;
  final String timestamp;

  const DailyLogSubmissionEntity({
    required this.projectId,
    required this.projectName,
    required this.milestoneName,
    required this.milestoneId,
    required this.location,
    required this.logDate,
    required this.mediaPaths,
    required this.isAiScanned,
    required this.aiScanResult,
    required this.workSummary,
    required this.equipmentUsed,
    required this.workersCount,
    required this.locationCoords,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [
        projectId,
        projectName,
        milestoneName,
        milestoneId,
        location,
        logDate,
        mediaPaths,
        isAiScanned,
        aiScanResult,
        workSummary,
        equipmentUsed,
        workersCount,
        locationCoords,
        timestamp,
      ];
}
