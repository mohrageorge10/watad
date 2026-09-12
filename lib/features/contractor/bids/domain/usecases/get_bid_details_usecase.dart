import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/bids/domain/repositories/contractor_bids_repository.dart';

class GetBidDetailsUseCase {
  final ContractorBidsRepository repository;

  GetBidDetailsUseCase(this.repository);

  Future<ApiResult<MyBidEntity?>> call(String bidId) async {
    return await repository.getBidDetails(bidId);
  }
}
