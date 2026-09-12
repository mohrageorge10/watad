import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_bid_entity.dart';

abstract class ContractorBidsRepository {
  Future<ApiResult<List<ContractorBidEntity>>> getContractorBids({
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<ApiResult<List<MyBidEntity>>> getMyBids();

  Future<ApiResult<bool>> submitBid({
    required String projectId,
    required String proposedCost,
    required String proposedDuration,
    required String technicalProposal,
    String? attachmentFilePath,
  });

  Future<ApiResult<bool>> cancelBid(String bidId);

  Future<ApiResult<MyBidEntity?>> getBidDetails(String bidId);
}
