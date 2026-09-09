import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/marketplace/data/datasources/marketplace_remote_data_source.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_details_entity.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';
import 'package:watad/features/contractor/marketplace/domain/repositories/marketplace_repository.dart';

class MarketplaceRepositoryImpl implements MarketplaceRepository {
  final MarketplaceRemoteDataSource remoteDataSource;

  MarketplaceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<MarketplaceProjectEntity>>> getMarketplaceProjects({
    String? category,
    String? searchQuery,
    String? governorate,
    int? minBudget,
    int? maxBudget,
    bool useRecommended = false,
  }) async {
    try {
      final projects = await remoteDataSource.getMarketplaceProjects(
        category: category,
        searchQuery: searchQuery,
        governorate: governorate,
        minBudget: minBudget,
        maxBudget: maxBudget,
        useRecommended: useRecommended,
      );
      return ApiResult.success(projects);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<MarketplaceProjectDetailsEntity>> getMarketplaceProjectDetails(
    String id,
  ) async {
    try {
      final details = await remoteDataSource.getMarketplaceProjectDetails(id);
      return ApiResult.success(details);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
