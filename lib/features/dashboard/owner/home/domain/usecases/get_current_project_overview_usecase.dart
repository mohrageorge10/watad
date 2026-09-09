import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/current_project_overview.dart';
import 'package:watad/features/dashboard/owner/home/domain/repositories/home_repository.dart';

class GetCurrentProjectOverviewUseCase {
  final HomeRepository repository;
  const GetCurrentProjectOverviewUseCase(this.repository);

  Future<ApiResult<CurrentProjectOverview>> call() {
    return repository.getCurrentProjectOverview();
  }
}
