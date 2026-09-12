import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/domain/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<PortfolioProjectItemModel>>> getPortfolioProjects({
    required String contractorId,
  }) async {
    try {
      final projects = await remoteDataSource.getPortfolioProjects(
        contractorId: contractorId,
      );
      return ApiResult.success(projects);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<PortfolioItemModel>>> fetchContractorPortfolio() async {
    try {
      final projects = await remoteDataSource.fetchContractorPortfolio();
      return ApiResult.success(projects);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<PortfolioProjectItemModel>> addPortfolioProject({
    required Map<String, dynamic> projectData,
  }) async {
    try {
      final project = await remoteDataSource.addPortfolioProject(
        projectData: projectData,
      );
      return ApiResult.success(project);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<PortfolioProjectItemModel>> updatePortfolioProject({
    required String projectId,
    required Map<String, dynamic> projectData,
  }) async {
    try {
      final project = await remoteDataSource.updatePortfolioProject(
        projectId: projectId,
        projectData: projectData,
      );
      return ApiResult.success(project);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<PortfolioProjectItemModel>> getPortfolioProjectDetails({
    required String projectId,
  }) async {
    try {
      final project = await remoteDataSource.getPortfolioProjectDetails(
        projectId: projectId,
      );
      return ApiResult.success(project);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<bool>> deletePortfolioProject({
    required String projectId,
  }) async {
    try {
      final success = await remoteDataSource.deletePortfolioProject(
        projectId: projectId,
      );
      return ApiResult.success(success);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
