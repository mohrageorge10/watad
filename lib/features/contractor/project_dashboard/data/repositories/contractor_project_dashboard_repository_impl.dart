import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/project_dashboard/data/datasources/contractor_project_dashboard_remote_data_source.dart';
import 'package:watad/features/contractor/project_dashboard/domain/entities/contractor_project_dashboard_entity.dart';
import 'package:watad/features/contractor/project_dashboard/domain/repositories/contractor_project_dashboard_repository.dart';

class ContractorProjectDashboardRepositoryImpl
    implements ContractorProjectDashboardRepository {
  final ContractorProjectDashboardRemoteDataSource remoteDataSource;

  ContractorProjectDashboardRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<ApiResult<ContractorProjectDashboardEntity>> getProjectDashboard(
    String projectId,
  ) async {
    try {
      final result = await remoteDataSource.getProjectDashboard(projectId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
