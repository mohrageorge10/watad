import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/home/data/datasources/home_remote_data_source.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/current_project_overview.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/paginated_projects.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/owner_profile.dart';
import 'package:watad/features/dashboard/owner/home/domain/repositories/home_repository.dart';


class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  const HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<CurrentProjectOverview>> getCurrentProjectOverview() async {
    try {
      final model = await remoteDataSource.getCurrentProjectOverview();
      return ApiResult.success(model);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<OwnerProfile>> getOwnerProfile() async {
    try {
      final model = await remoteDataSource.getOwnerProfile();
      return ApiResult.success(model);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<PaginatedProjects>> getOwnerProjects({
    int? status,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      final model = await remoteDataSource.getOwnerProjects(
        status: status,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return ApiResult.success(model);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
