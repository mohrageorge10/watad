import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/marketplace/data/datasources/marketplace_remote_data_source.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';
import 'package:watad/features/contractor/marketplace/domain/repositories/marketplace_repository.dart';

class MarketplaceRepositoryImpl implements MarketplaceRepository {
  final MarketplaceRemoteDataSource remoteDataSource;

  MarketplaceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<MarketplaceProjectEntity>>> getMarketplaceProjects({
    String? category,
    String? searchQuery,
  }) async {
    try {
      final projects = await remoteDataSource.getMarketplaceProjects(
        category: category,
        searchQuery: searchQuery,
      );
      return ApiResult.success(projects);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
