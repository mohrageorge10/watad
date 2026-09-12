import 'package:watad/features/contractor/milestone_inspection/domain/entities/milestone_inspection_details_entity.dart';

class MockMilestoneInspectionData {
  static MilestoneInspectionDetailsEntity getMockInspectionDetails({String? milestoneId}) {
    return const MilestoneInspectionDetailsEntity(
      milestoneId: 'ms_101',
      title: 'Concrete Pouring for Roof Slab',
      phaseSubtitle: 'Phase 1 • Excavation & Foundation',
      progressPercent: 1.0, // 100%
      siteLogsCount: 12,
      startDateFormatted: 'Sep 1, 2024',
      expectedEndDateFormatted: 'Sep 14, 2024',
      galleryItems: [
        InspectionGalleryItemEntity(
          id: 'log_gal_1',
          imageUrl:
              'https://images.unsplash.com/photo-1541888946425-d0fbb18f15f6?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 12, 2026',
          badgeType: InspectionLogBadgeType.aiVerified,
          badgeText: '✓ AI Verified',
          confidence: '98%',
          location: 'Roof Slab • Grid A-3',
          analysisVerdict: 'Concrete curing and structural steel rebar placement verified against standard specs.',
          recommendation: 'Approved for loading and curing cycle.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_2',
          imageUrl:
              'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 11, 2026',
          badgeType: InspectionLogBadgeType.aiVerified,
          badgeText: '✓ AI Verified',
          confidence: '95%',
          location: 'Beam Joint • Zone 2',
          analysisVerdict: 'Rebar overlap and tie-wire spacing meet safety engineering codes.',
          recommendation: 'Zero defects found. Proceed to next stage.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_3',
          imageUrl:
              'https://images.unsplash.com/photo-1581092160607-ee22621dd758?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 11, 2026',
          badgeType: InspectionLogBadgeType.defectDetected,
          badgeText: '⊘ Defect Detected',
          confidence: '92%',
          location: 'Wall - Section B',
          defectType: 'Structural Surface Crack',
          severity: 'High Severity',
          analysisVerdict: 'Visible vertical hairline fissure detected along structural wall interface.',
          recommendation: 'Monitor and repair with epoxy injection within 7 days before final signoff.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_4',
          imageUrl:
              'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 10, 2026',
          badgeType: InspectionLogBadgeType.aiVerified,
          badgeText: '✓ AI Verified',
          confidence: '97%',
          location: 'Formwork • Section C',
          analysisVerdict: 'Shuttering formwork alignment verified. Adequate lateral bracing installed.',
          recommendation: 'Quality approved for concrete pour.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_5',
          imageUrl:
              'https://images.unsplash.com/photo-1590069261209-f8e9b8642343?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 9, 2026',
          badgeType: InspectionLogBadgeType.aiVerified,
          badgeText: '✓ AI Verified',
          confidence: '96%',
          location: 'Steel Truss Framing',
          analysisVerdict: 'Truss welds and bolt torque checked with ISO 9001 compliance standards.',
          recommendation: 'Structural alignment verified.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_6',
          imageUrl:
              'https://images.unsplash.com/photo-1541888946425-d0fbb18f15f6?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 8, 2026',
          badgeType: InspectionLogBadgeType.aiVerified,
          badgeText: '✓ AI Verified',
          confidence: '94%',
          location: 'Foundation Slab',
          analysisVerdict: 'Subgrade moisture barrier and vapor retarder confirmed intact.',
          recommendation: 'Approved for inspection record.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_7',
          imageUrl:
              'https://images.unsplash.com/photo-1503387762-592deb58ef4e?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 7, 2026',
          badgeType: InspectionLogBadgeType.aiVerified,
          badgeText: '✓ AI Verified',
          confidence: '99%',
          location: 'Main Column C1',
          analysisVerdict: 'Verticality check passed with deviation within tolerance of ±2mm.',
          recommendation: 'Column casting approved.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_8',
          imageUrl:
              'https://images.unsplash.com/photo-1581094794329-c8112a89af12?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 6, 2026',
          badgeType: InspectionLogBadgeType.aiVerified,
          badgeText: '✓ AI Verified',
          confidence: '93%',
          location: 'Electrical Conduits',
          analysisVerdict: 'Embedded conduit pathways and junction boxes secured properly.',
          recommendation: 'MEP pre-pour inspection passed.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_9',
          imageUrl:
              'https://images.unsplash.com/photo-1572981779307-38b8cabb2407?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 5, 2026',
          badgeType: InspectionLogBadgeType.defectDetected,
          badgeText: '⊘ Defect Detected',
          confidence: '89%',
          location: 'Beam End • Grid 4',
          defectType: 'Honeycombing & Void Risk',
          severity: 'Medium Severity',
          analysisVerdict: 'Insufficient vibration detected near dense rebar cluster causing small surface voids.',
          recommendation: 'Apply structural polymer grout patch prior to final slab inspection.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_10',
          imageUrl:
              'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 4, 2026',
          badgeType: InspectionLogBadgeType.aiVerified,
          badgeText: '✓ AI Verified',
          confidence: '97%',
          location: 'Secondary Stirrups',
          analysisVerdict: 'Shear reinforcement spacing verified according to structural blueprint.',
          recommendation: 'Approved for casting.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_11',
          imageUrl:
              'https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 3, 2026',
          badgeType: InspectionLogBadgeType.aiVerified,
          badgeText: '✓ AI Verified',
          confidence: '95%',
          location: 'Boundary Wall',
          analysisVerdict: 'Perimeter masonry work verified. Mortar joint thickness consistent.',
          recommendation: 'Accepted.',
        ),
        InspectionGalleryItemEntity(
          id: 'log_gal_12',
          imageUrl:
              'https://images.unsplash.com/photo-1541888946425-d0fbb18f15f6?w=600&auto=format&fit=crop',
          dateFormatted: 'Sep 2, 2026',
          badgeType: InspectionLogBadgeType.aiVerified,
          badgeText: '✓ AI Verified',
          confidence: '98%',
          location: 'Initial Excavation Pit',
          analysisVerdict: 'Depth and soil compaction level confirmed by on-site surveyor AI telemetry.',
          recommendation: 'Milestone baseline recorded.',
        ),
      ],
    );
  }
}
