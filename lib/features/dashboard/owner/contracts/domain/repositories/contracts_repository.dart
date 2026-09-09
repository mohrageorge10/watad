import 'package:watad/core/network/api/api_result.dart';
import '../../data/models/create_contract_request_dto.dart';
import '../../data/models/contract_details_dto.dart';

abstract class ContractsRepository {
  Future<ApiResult<String>> createContract(CreateContractRequestDto request);
  Future<ApiResult<ContractDetailsDto>> getContractDetails(String id);
  Future<ApiResult<String>> generateContractPdf(String projectId, String contractId);
}
