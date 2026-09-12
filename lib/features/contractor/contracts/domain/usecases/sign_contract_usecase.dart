import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/contracts/domain/repositories/contracts_repository.dart';

class SignContractUseCase {
  final ContractsRepository repository;

  SignContractUseCase(this.repository);

  Future<ApiResult<bool>> call(
    String contractId, {
    String? digitalSignature,
  }) async {
    return await repository.signContract(
      contractId,
      digitalSignature: digitalSignature,
    );
  }
}
