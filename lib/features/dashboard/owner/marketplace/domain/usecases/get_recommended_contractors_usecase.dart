import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/contractor_profile.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/repositories/marketplace_repository.dart';

class GetRecommendedContractorsUseCase {
  final MarketplaceRepository repository;

  GetRecommendedContractorsUseCase(this.repository);

  Future<ApiResult<List<ContractorProfile>>> call(String projectId) {
    return repository.getRecommendedContractors(projectId);
  }
}
