import 'phase_progress_item.dart';
import 'site_update_photo.dart';

class ProgressUpdatesData {
  final int overallProgress;
  final List<PhaseProgressItem> phaseProgressList;
  final List<SiteUpdatePhoto> siteUpdatePhotos;

  ProgressUpdatesData({
    required this.overallProgress,
    required this.phaseProgressList,
    required this.siteUpdatePhotos,
  });
}
