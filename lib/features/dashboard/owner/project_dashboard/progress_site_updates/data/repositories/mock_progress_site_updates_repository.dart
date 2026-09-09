import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/progress_site_updates/domain/entities/phase_progress_item.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/progress_site_updates/domain/entities/progress_updates_data.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/progress_site_updates/domain/entities/site_update_photo.dart';


class MockProgressSiteUpdatesRepository {
  Future<ProgressUpdatesData> getProgressSiteUpdates() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return ProgressUpdatesData(
      overallProgress: 68,
      phaseProgressList: [
        PhaseProgressItem(
          title: "Foundation",
          percentage: 100,
          indicatorColor: AppColors.accept, // Green
        ),
        PhaseProgressItem(
          title: "Structure",
          percentage: 65,
          indicatorColor: AppColors.icon, // Yellow/Orange
        ),
        PhaseProgressItem(
          title: "Finishing",
          percentage: 35,
          indicatorColor: AppColors.grey400, // Grey
        ),
        PhaseProgressItem(
          title: "MEP",
          percentage: 20,
          indicatorColor: AppColors.grey400, // Grey
        ),
      ],
      siteUpdatePhotos: [
        SiteUpdatePhoto(
          imageUrl: "https://images.unsplash.com/photo-1541888081622-15cb3a62cd2e?w=500&auto=format&fit=crop&q=60",
          title: "Steel Works",
          timeText: "10:30 AM",
        ),
        SiteUpdatePhoto(
          imageUrl: "https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=500&auto=format&fit=crop&q=60",
          title: "Concrete Pour",
          timeText: "09:15 AM",
        ),
        SiteUpdatePhoto(
          imageUrl: "https://images.unsplash.com/photo-1589939705384-5185137a7f0f?w=500&auto=format&fit=crop&q=60",
          title: "Block Work",
          timeText: "Yesterday",
        ),
      ],
    );
  }
}
