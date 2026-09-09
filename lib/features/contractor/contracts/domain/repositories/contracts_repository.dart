import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/contracts/domain/entities/contract_entity.dart';

abstract class ContractsRepository {
  Future<ApiResult<ContractEntity>> getContractDetails(String contractId);
  Future<ApiResult<bool>> signContract(String contractId, {String? digitalSignature});
  Future<ApiResult<ContractEntity?>> getAcceptedBidContract(String bidId);
}
