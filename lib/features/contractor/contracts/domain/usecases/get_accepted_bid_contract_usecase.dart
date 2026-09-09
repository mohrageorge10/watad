import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/contracts/domain/entities/contract_entity.dart';
import 'package:watad/features/contractor/contracts/domain/repositories/contracts_repository.dart';

class GetAcceptedBidContractUseCase {
  final ContractsRepository repository;

  GetAcceptedBidContractUseCase(this.repository);

  Future<ApiResult<ContractEntity?>> call(String bidId) async {
    return await repository.getAcceptedBidContract(bidId);
  }
}
