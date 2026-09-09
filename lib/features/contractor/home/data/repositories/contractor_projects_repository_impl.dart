import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/home/data/datasources/contractor_projects_remote_data_source.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_project_entity.dart';
import 'package:watad/features/contractor/home/domain/repositories/contractor_projects_repository.dart';

class ContractorProjectsRepositoryImpl implements ContractorProjectsRepository {
  final ContractorProjectsRemoteDataSource remoteDataSource;

  ContractorProjectsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<ContractorProjectEntity>>> getContractorProjects({
    int? status,
  }) async {
    try {
      final projects = await remoteDataSource.fetchContractorProjects(
        status: status,
      );
      return ApiResult.success(projects);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
