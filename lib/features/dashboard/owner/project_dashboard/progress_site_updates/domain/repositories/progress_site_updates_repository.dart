import 'package:watad/core/network/api/api_result.dart';
import '../entities/progress_updates_data.dart';

abstract class ProgressSiteUpdatesRepository {
  Future<ApiResult<ProgressUpdatesData>> getProgressUpdates(String projectId);
}
