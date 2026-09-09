import 'package:flutter/material.dart';
import '../../domain/entities/dashboard_data.dart';
import '../../domain/repositories/project_dashboard_repository.dart';

class MockProjectDashboardRepository implements ProjectDashboardRepository {
  @override
  Future<DashboardData> getDashboardData(String projectId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    return DashboardData(
      projectName: 'Villa – New Cairo',
      progress: ConstructionProgress(
        overallPercentage: 68,
        elapsedPercentage: 54,
        currentStage: 'Phase 2',
        stageStatus: 'On Track',
        daysToFinish: 32,
      ),
      quickAccessItems: [
        QuickAccessItem(
          title: 'Financial\nSummary',
          iconData: Icons.credit_card_outlined,
        ),
        QuickAccessItem(
          title: 'Change\nOrders',
          iconData: Icons.description_outlined,
          notificationCount: 2,
        ),
        QuickAccessItem(
          title: 'Progress &\nSite Updates',
          iconData: Icons.image_outlined,
        ),
        QuickAccessItem(
          title: 'Alerts &\nActivity Feed',
          iconData: Icons.notifications_none_outlined,
        ),
      ],
      activityFeed: [
        ActivityFeedItem(
          title: 'Excavation – Zone A',
          time: '09:30 AM',
          status: ActivityStatus.verified,
        ),
        ActivityFeedItem(
          title: 'Rebar Installation –\nGround Floor',
          time: '10:15 AM',
          status: ActivityStatus.issue,
        ),
        ActivityFeedItem(
          title: 'Column Casting – Axis 3',
          time: '11:45 AM',
          status: ActivityStatus.verified,
        ),
      ],
    );
  }
}
