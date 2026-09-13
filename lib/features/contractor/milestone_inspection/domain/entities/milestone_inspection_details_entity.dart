import 'package:equatable/equatable.dart';

enum InspectionLogBadgeType {
  aiVerified,
  defectDetected,
  pending,
}

class InspectionGalleryItemEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String dateFormatted;
  final InspectionLogBadgeType badgeType;
  final String badgeText;
  final String? confidence;
  final String? location;
  final String? analysisVerdict;
  final String? defectType;
  final String? recommendation;
  final String? severity;

  const InspectionGalleryItemEntity({
    required this.id,
    required this.imageUrl,
    required this.dateFormatted,
    required this.badgeType,
    required this.badgeText,
    this.confidence,
    this.location,
    this.analysisVerdict,
    this.defectType,
    this.recommendation,
    this.severity,
  });

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        dateFormatted,
        badgeType,
        badgeText,
        confidence,
        location,
        analysisVerdict,
        defectType,
        recommendation,
        severity,
      ];
}

class MilestoneInspectionDetailsEntity extends Equatable {
  final String milestoneId;
  final String title;
  final String phaseSubtitle;
  final double progressPercent; // 0.0 to 1.0 (e.g. 1.0 = 100%)
  final int siteLogsCount;
  final String startDateFormatted;
  final String expectedEndDateFormatted;
  final List<InspectionGalleryItemEntity> galleryItems;

  const MilestoneInspectionDetailsEntity({
    required this.milestoneId,
    required this.title,
    required this.phaseSubtitle,
    required this.progressPercent,
    required this.siteLogsCount,
    required this.startDateFormatted,
    required this.expectedEndDateFormatted,
    required this.galleryItems,
  });

  @override
  List<Object?> get props => [
        milestoneId,
        title,
        phaseSubtitle,
        progressPercent,
        siteLogsCount,
        startDateFormatted,
        expectedEndDateFormatted,
        galleryItems,
      ];
}
