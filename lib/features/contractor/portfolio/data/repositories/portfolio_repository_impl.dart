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
}
