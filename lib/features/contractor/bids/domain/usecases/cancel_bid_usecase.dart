import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/bids/domain/repositories/contractor_bids_repository.dart';

class CancelBidUseCase {
  final ContractorBidsRepository repository;

  CancelBidUseCase(this.repository);

  Future<ApiResult<bool>> call(String bidId) async {
    return await repository.cancelBid(bidId);
  }
}
