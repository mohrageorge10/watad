import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/paginated_projects.dart';
import 'package:watad/features/dashboard/owner/home/domain/repositories/home_repository.dart';


class GetOwnerProjectsUseCase {
  final HomeRepository repository;
  const GetOwnerProjectsUseCase(this.repository);

  Future<ApiResult<PaginatedProjects>> call({
    int? status,
    required int pageNumber,
    required int pageSize,
  }) {
    return repository.getOwnerProjects(
      status: status,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
