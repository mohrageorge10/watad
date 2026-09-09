import 'package:watad/core/network/api/api_result.dart';
import '../../data/models/create_contract_request_dto.dart';
import '../repositories/contracts_repository.dart';

class CreateContractUseCase {
  final ContractsRepository repository;

  CreateContractUseCase({required this.repository});

  Future<ApiResult<String>> call(CreateContractRequestDto request) {
    return repository.createContract(request);
  }
}
