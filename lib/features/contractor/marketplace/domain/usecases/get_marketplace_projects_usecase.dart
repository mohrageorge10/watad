import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';
import 'package:watad/features/contractor/marketplace/domain/repositories/marketplace_repository.dart';

class GetMarketplaceProjectsUseCase {
  final MarketplaceRepository repository;

  const GetMarketplaceProjectsUseCase(this.repository);

  Future<ApiResult<List<MarketplaceProjectEntity>>> call({
    String? category,
    String? searchQuery,
  }) async {
    return await repository.getMarketplaceProjects(
      category: category,
      searchQuery: searchQuery,
    );
  }
}
