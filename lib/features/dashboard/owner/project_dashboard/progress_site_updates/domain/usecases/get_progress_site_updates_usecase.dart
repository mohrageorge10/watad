import 'package:watad/core/network/api/api_result.dart';
import '../entities/progress_updates_data.dart';
import '../repositories/progress_site_updates_repository.dart';

class GetProgressSiteUpdatesUseCase {
  final ProgressSiteUpdatesRepository repository;

  GetProgressSiteUpdatesUseCase(this.repository);

  Future<ApiResult<ProgressUpdatesData>> call(String projectId) {
    return repository.getProgressUpdates(projectId);
  }
}
