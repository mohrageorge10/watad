import 'package:watad/core/network/api/api_result.dart';
import '../../data/models/contract_details_dto.dart';
import '../repositories/contracts_repository.dart';

class GetContractDetailsUseCase {
  final ContractsRepository repository;

  GetContractDetailsUseCase({required this.repository});

  Future<ApiResult<ContractDetailsDto>> call(String id) {
    return repository.getContractDetails(id);
  }
}
