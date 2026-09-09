import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';

abstract class MarketplaceRepository {
  Future<ApiResult<List<MarketplaceProjectEntity>>> getMarketplaceProjects({
    String? category,
    String? searchQuery,
  });
}
