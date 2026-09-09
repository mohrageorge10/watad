import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/contracts/domain/entities/contract_entity.dart';
import 'package:watad/features/contractor/contracts/domain/repositories/contracts_repository.dart';

class GetContractDetailsUseCase {
  final ContractsRepository repository;

  GetContractDetailsUseCase(this.repository);

  Future<ApiResult<ContractEntity>> call(String contractId) async {
    return await repository.getContractDetails(contractId);
  }
}
