import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/contracts/data/datasources/contracts_remote_data_source.dart';
import 'package:watad/features/contractor/contracts/domain/entities/contract_entity.dart';
import 'package:watad/features/contractor/contracts/domain/repositories/contracts_repository.dart';

class ContractsRepositoryImpl implements ContractsRepository {
  final ContractsRemoteDataSource remoteDataSource;

  ContractsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<ContractEntity>> getContractDetails(String contractId) async {
    try {
      final contract = await remoteDataSource.getContractDetails(contractId);
      return ApiResult.success(contract);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<bool>> signContract(
    String contractId, {
    String? digitalSignature,
  }) async {
    try {
      final result = await remoteDataSource.signContract(
        contractId,
        digitalSignature: digitalSignature,
      );
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<ContractEntity?>> getAcceptedBidContract(String bidId) async {
    try {
      final contract = await remoteDataSource.getAcceptedBidContract(bidId);
      return ApiResult.success(contract);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
