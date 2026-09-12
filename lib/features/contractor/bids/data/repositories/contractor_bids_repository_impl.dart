import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/bids/data/datasources/contractor_bids_remote_data_source.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/bids/domain/repositories/contractor_bids_repository.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_bid_entity.dart';

class ContractorBidsRepositoryImpl implements ContractorBidsRepository {
  final ContractorBidsRemoteDataSource remoteDataSource;

  ContractorBidsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<List<ContractorBidEntity>>> getContractorBids({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final bids = await remoteDataSource.fetchContractorBids(
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return ApiResult.success(bids);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<List<MyBidEntity>>> getMyBids() async {
    try {
      final bids = await remoteDataSource.fetchMyBids();
      return ApiResult.success(bids);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<bool>> submitBid({
    required String projectId,
    required String proposedCost,
    required String proposedDuration,
    required String technicalProposal,
    String? attachmentFilePath,
  }) async {
    try {
      final result = await remoteDataSource.submitBid(
        projectId: projectId,
        proposedCost: proposedCost,
        proposedDuration: proposedDuration,
        technicalProposal: technicalProposal,
        attachmentFilePath: attachmentFilePath,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<bool>> cancelBid(String bidId) async {
    try {
      final result = await remoteDataSource.cancelBid(bidId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<MyBidEntity?>> getBidDetails(String bidId) async {
    try {
      final details = await remoteDataSource.getBidDetails(bidId);
      return ApiResult.success(details);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
