import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_details_entity.dart';
import 'package:watad/features/contractor/marketplace/domain/repositories/marketplace_repository.dart';

class GetMarketplaceProjectDetailsUseCase {
  final MarketplaceRepository repository;

  GetMarketplaceProjectDetailsUseCase(this.repository);

  Future<ApiResult<MarketplaceProjectDetailsEntity>> call(String id) {
    return repository.getMarketplaceProjectDetails(id);
  }
}
