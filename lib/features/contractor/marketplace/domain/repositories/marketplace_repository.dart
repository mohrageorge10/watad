import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_details_entity.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';

abstract class MarketplaceRepository {
  Future<ApiResult<List<MarketplaceProjectEntity>>> getMarketplaceProjects({
    String? category,
    String? searchQuery,
    String? governorate,
    int? minBudget,
    int? maxBudget,
    bool useRecommended = false,
  });

  Future<ApiResult<MarketplaceProjectDetailsEntity>> getMarketplaceProjectDetails(
    String id,
  );
}
