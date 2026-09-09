import 'package:watad/core/network/api/api_result.dart';
import '../repositories/contracts_repository.dart';

class GenerateContractPdfUseCase {
  final ContractsRepository repository;

  GenerateContractPdfUseCase({required this.repository});

  Future<ApiResult<String>> call(String projectId, String contractId) {
    return repository.generateContractPdf(projectId, contractId);
  }
}
