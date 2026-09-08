import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/bids/data/datasources/contractor_bids_remote_data_source.dart';
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
}
