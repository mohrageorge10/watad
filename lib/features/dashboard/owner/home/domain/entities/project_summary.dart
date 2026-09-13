import 'package:equatable/equatable.dart';

class ProjectSummary extends Equatable {
  final String projectId;
  final String title;
  final String? imageUrl;
  final String location;
  final String status;
  final num overallProgressPercentage;
  final DateTime? updatedAt;
  final bool hasContract;

  const ProjectSummary({
    required this.projectId,
    required this.title,
    this.imageUrl,
    required this.location,
    required this.status,
    required this.overallProgressPercentage,
    this.updatedAt,
    this.hasContract = false,
  });

  @override
  List<Object?> get props => [
        projectId,
        title,
        imageUrl,
        location,
        status,
        overallProgressPercentage,
        updatedAt,
        hasContract,
      ];
}
