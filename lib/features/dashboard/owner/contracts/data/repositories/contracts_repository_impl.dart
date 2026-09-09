import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/network/api/api_result.dart';
import '../datasources/contracts_remote_data_source.dart';
import '../../domain/repositories/contracts_repository.dart';
import '../models/create_contract_request_dto.dart';
import '../models/contract_details_dto.dart';

class ContractsRepositoryImpl implements ContractsRepository {
  final ContractsRemoteDataSource remoteDataSource;

  const ContractsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<String>> createContract(CreateContractRequestDto request) async {
    try {
      final result = await remoteDataSource.createContract(request);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<ContractDetailsDto>> getContractDetails(String id) async {
    try {
      final result = await remoteDataSource.getContractDetails(id);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<String>> generateContractPdf(String projectId, String contractId) async {
    try {
      final result = await remoteDataSource.generateContractPdf(projectId, contractId);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
