

import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/current_project_overview.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/paginated_projects.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/owner_profile.dart';

abstract class HomeRepository {
  Future<ApiResult<CurrentProjectOverview>> getCurrentProjectOverview();

  Future<ApiResult<PaginatedProjects>> getOwnerProjects({
    int? status,
    required int pageNumber,
    required int pageSize,
  });

  Future<ApiResult<OwnerProfile>> getOwnerProfile();
}
