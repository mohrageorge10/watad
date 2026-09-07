import 'package:equatable/equatable.dart';

class CurrentProjectOverview extends Equatable {
  final String? projectId;
  final String title;
  final String status;
  final String location;
  final String city;
  final String governorate;
  final String? imageUrl;
  final num overallProgressPercentage;
  final DateTime? startDate;
  final String? nextMilestoneTitle;
  final int daysElapsed;
  final DateTime? estimatedCompletionDate;
  final bool hasActiveProject;

  const CurrentProjectOverview({
    this.projectId,
    required this.title,
    required this.status,
    required this.location,
    required this.city,
    required this.governorate,
    this.imageUrl,
    required this.overallProgressPercentage,
    this.startDate,
    this.nextMilestoneTitle,
    required this.daysElapsed,
    this.estimatedCompletionDate,
    required this.hasActiveProject,
  });

  @override
  List<Object?> get props => [
        projectId,
        title,
        status,
        location,
        city,
        governorate,
        imageUrl,
        overallProgressPercentage,
        startDate,
        nextMilestoneTitle,
        daysElapsed,
        estimatedCompletionDate,
        hasActiveProject,
      ];
}
