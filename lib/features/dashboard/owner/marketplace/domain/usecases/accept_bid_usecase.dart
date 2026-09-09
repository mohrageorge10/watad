import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/repositories/marketplace_repository.dart';

class AcceptBidUseCase {
  final MarketplaceRepository repository;

  AcceptBidUseCase(this.repository);

  Future<ApiResult<void>> call(String bidId) {
    return repository.acceptBid(bidId);
  }
}
