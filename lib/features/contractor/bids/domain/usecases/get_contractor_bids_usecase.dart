import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/bids/domain/repositories/contractor_bids_repository.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_bid_entity.dart';

class GetContractorBidsUseCase {
  final ContractorBidsRepository repository;

  GetContractorBidsUseCase(this.repository);

  Future<ApiResult<List<ContractorBidEntity>>> call({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    return await repository.getContractorBids(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
