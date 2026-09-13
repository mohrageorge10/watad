import 'package:watad/features/contractor/milestone_logs/data/models/milestone_log_item_model.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';

class MockMilestoneLogsData {
  MockMilestoneLogsData._();

  static MilestoneLogsHeaderModel getMockHeader({
    String? projectId,
    String? projectName,
  }) {
    return MilestoneLogsHeaderModel(
      projectId: projectId ?? 'proj_1',
      projectName: projectName ?? 'Modern Villa Alpha',
      phaseName: 'Phase 1',
      milestoneName: 'Excavation & Foundation',
      status: 'Active',
      estCompletionDate: 'Nov 25, 2026',
    );
  }

  static List<MilestoneLogItemModel> getMockLogs() {
    return const [
      // 1. Daily Log with AI Verification & Photos
      MilestoneLogItemModel(
        id: 'log_1',
        type: MilestoneLogType.dailyLog,
        title: 'Foundation Pouring',
        authorName: 'Ahmed Al-Masry',
        authorRole: 'Site Engineer',
        timeFormatted: 'Today, 09:30 AM',
        description:
            'Foundation pouring completed for sector B. Weather conditions optimal. Curing process initiated.',
        thumbnail:
            'https://images.unsplash.com/photo-1541888946425-d0fbb18f15f9?q=80&w=400&auto=format&fit=crop',
        attachedImages: [
          'https://images.unsplash.com/photo-1504307651254-35680f356dfd?q=80&w=400&auto=format&fit=crop',
          'https://images.unsplash.com/photo-1581094794329-c8112a89af12?q=80&w=400&auto=format&fit=crop',
        ],
        aiConfidence: 'AI Verified: 98% Confidence',
        milestoneProgressPercent: 'Milestone Progress: +12%',
      ),

      // 2. QA/QC Log
      MilestoneLogItemModel(
        id: 'log_2',
        type: MilestoneLogType.qaQc,
        title: 'Rebar Inspection',
        authorName: 'Sarah Mansour',
        authorRole: 'QA/QC',
        timeFormatted: 'Yesterday, 10:15 AM',
        description:
            'Rebar inspection passed for sector B. Spacing and overlap meet structural specifications. Cleared for pouring.',
        thumbnail:
            'https://images.unsplash.com/photo-1504307651254-35680f356dfd?q=80&w=400&auto=format&fit=crop',
      ),

      // 3. Safety Alert Log
      MilestoneLogItemModel(
        id: 'log_3',
        type: MilestoneLogType.safety,
        title: 'Weather & Visibility Notice',
        authorName: 'Khaled Ibrahim',
        authorRole: 'Safety Officer',
        timeFormatted: 'Oct 05, 08:00 AM',
        description:
            'Minor delay due to heavy morning fog. Work resumed at 09:30 AM after visibility improved to safe levels.',
        isWarning: true,
      ),

      // 4. System Milestone Initiated Log
      MilestoneLogItemModel(
        id: 'log_4',
        type: MilestoneLogType.system,
        title: 'Milestone Initiated',
        authorName: 'System',
        authorRole: 'Automated',
        timeFormatted: 'Oct 01, 07:00 AM',
        description: "Milestone 'Excavation & Foundation' initiated.",
      ),
    ];
  }
}
