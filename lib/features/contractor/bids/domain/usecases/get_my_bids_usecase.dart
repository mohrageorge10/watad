import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/bids/domain/repositories/contractor_bids_repository.dart';

class GetMyBidsUseCase {
  final ContractorBidsRepository repository;

  GetMyBidsUseCase(this.repository);

  Future<ApiResult<List<MyBidEntity>>> call() async {
    return await repository.getMyBids();
  }
}
