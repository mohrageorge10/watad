import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/repositories/marketplace_repository.dart';

class RejectBidUseCase {
  final MarketplaceRepository repository;

  RejectBidUseCase(this.repository);

  Future<ApiResult<void>> call(String bidId) {
    return repository.rejectBid(bidId);
  }
}
