import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/bid_details.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/repositories/marketplace_repository.dart';

class GetBidDetailsUseCase {
  final MarketplaceRepository repository;

  GetBidDetailsUseCase(this.repository);

  Future<ApiResult<BidDetails>> call(String bidId) {
    return repository.getBidDetails(bidId);
  }
}
