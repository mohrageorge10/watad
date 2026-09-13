import 'package:watad/features/contractor/project_dashboard/data/models/contractor_project_dashboard_model.dart';

class ContractorProjectDashboardMockData {
  ContractorProjectDashboardMockData._();

  static ContractorProjectDashboardModel getMockDashboard({
    String? projectId,
    String? projectTitle,
  }) {
    return ContractorProjectDashboardModel(
      projectId: projectId ?? 'proj_1',
      projectCode: 'WTD-2026-089',
      title: projectTitle ?? 'Modern Villa Alpha',
      location: 'New Cairo, Cairo',
      imageUrl: 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=1200&auto=format&fit=crop',
      status: 'Active',
      landArea: '1,200 m²',
      floors: '2',
      finishingLevel: 'Premium',
      contractValue: 'EGP 2,450,000',
      startDate: 'Nov 01, 2026',
      endDate: 'May 01, 2027',
      overallProgress: 42,
      completedProgress: 42,
      inProgressProgress: 38,
      notStartedProgress: 20,
      activeMilestone: const ActiveMilestoneModel(
        id: 'ms_1',
        title: 'Excavation & Foundation',
        status: 'In Progress',
        targetDate: 'Nov 25, 2026',
        nextPayment: 'EGP 350,000',
      ),
      dailyLogs: [
        DailyLogModel(
          id: 'log_1',
          imageUrl: 'https://images.unsplash.com/photo-1541888946425-d0fbb18f15f9?q=80&w=400&auto=format&fit=crop',
          isAiVerified: true,
          createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        DailyLogModel(
          id: 'log_2',
          imageUrl: 'https://images.unsplash.com/photo-1504307651254-35680f356dfd?q=80&w=400&auto=format&fit=crop',
          isAiVerified: true,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        DailyLogModel(
          id: 'log_3',
          imageUrl: 'https://images.unsplash.com/photo-1581094794329-c8112a89af12?q=80&w=400&auto=format&fit=crop',
          isAiVerified: true,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
      ],
    );
  }
}
