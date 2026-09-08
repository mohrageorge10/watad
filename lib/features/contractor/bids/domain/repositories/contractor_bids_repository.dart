import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_bid_entity.dart';

abstract class ContractorBidsRepository {
  Future<ApiResult<List<ContractorBidEntity>>> getContractorBids({
    int pageNumber = 1,
    int pageSize = 10,
  });
}
