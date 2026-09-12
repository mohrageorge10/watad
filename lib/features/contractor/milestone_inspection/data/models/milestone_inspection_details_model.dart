import 'package:watad/features/contractor/milestone_inspection/domain/entities/milestone_inspection_details_entity.dart';

class InspectionGalleryItemModel extends InspectionGalleryItemEntity {
  const InspectionGalleryItemModel({
    required super.id,
    required super.imageUrl,
    required super.dateFormatted,
    required super.badgeType,
    required super.badgeText,
  });

  factory InspectionGalleryItemModel.fromJson(Map<String, dynamic> json) {
    final badgeStr = (json['badgeType'] ?? json['status'] ?? '').toString().toLowerCase();
    InspectionLogBadgeType badgeType = InspectionLogBadgeType.aiVerified;
    String badgeText = 'AI Verified';

    if (badgeStr.contains('defect') || badgeStr.contains('defect_detected') || badgeStr.contains('warning')) {
      badgeType = InspectionLogBadgeType.defectDetected;
      badgeText = 'Defect Detected';
    } else if (badgeStr.contains('pending')) {
      badgeType = InspectionLogBadgeType.pending;
      badgeText = 'Pending';
    }

    return InspectionGalleryItemModel(
      id: json['id']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? json['mediaUrl']?.toString() ?? '',
      dateFormatted: json['dateFormatted']?.toString() ?? json['createdAt']?.toString() ?? '',
      badgeType: badgeType,
      badgeText: json['badgeText']?.toString() ?? badgeText,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'dateFormatted': dateFormatted,
      'badgeType': badgeType.name,
      'badgeText': badgeText,
    };
  }
}

class MilestoneInspectionDetailsModel extends MilestoneInspectionDetailsEntity {
  const MilestoneInspectionDetailsModel({
    required super.milestoneId,
    required super.title,
    required super.phaseSubtitle,
    required super.progressPercent,
    required super.siteLogsCount,
    required super.startDateFormatted,
    required super.expectedEndDateFormatted,
    required super.galleryItems,
  });

  factory MilestoneInspectionDetailsModel.fromJson(Map<String, dynamic> json) {
    final rawGallery = json['galleryItems'] ?? json['siteLogs'] ?? json['photos'] ?? [];
    List<InspectionGalleryItemEntity> gallery = [];
    if (rawGallery is List) {
      gallery = rawGallery
          .map((item) => InspectionGalleryItemModel.fromJson(
              item is Map<String, dynamic> ? item : {'imageUrl': item.toString()}))
          .toList();
    }

    double progress = 1.0;
    if (json['progressPercent'] != null) {
      final p = json['progressPercent'];
      if (p is num) {
        progress = p > 1.0 ? (p / 100.0) : p.toDouble();
      }
    }

    return MilestoneInspectionDetailsModel(
      milestoneId: json['milestoneId']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Concrete Pouring for Roof Slab',
      phaseSubtitle:
          json['phaseSubtitle']?.toString() ?? 'Phase 1 • Excavation & Foundation',
      progressPercent: progress,
      siteLogsCount: json['siteLogsCount'] as int? ?? 12,
      startDateFormatted: json['startDateFormatted']?.toString() ?? 'Sep 1, 2024',
      expectedEndDateFormatted:
          json['expectedEndDateFormatted']?.toString() ?? 'Sep 14, 2024',
      galleryItems: gallery,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'milestoneId': milestoneId,
      'title': title,
      'phaseSubtitle': phaseSubtitle,
      'progressPercent': progressPercent,
      'siteLogsCount': siteLogsCount,
      'startDateFormatted': startDateFormatted,
      'expectedEndDateFormatted': expectedEndDateFormatted,
      'galleryItems': galleryItems
          .map((g) => (g is InspectionGalleryItemModel)
              ? g.toJson()
              : {
                  'id': g.id,
                  'imageUrl': g.imageUrl,
                  'dateFormatted': g.dateFormatted,
                  'badgeType': g.badgeType.name,
                  'badgeText': g.badgeText,
                })
          .toList(),
    };
  }
}
