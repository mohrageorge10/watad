import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_home_entity.dart';
import 'package:watad/features/contractor/home/domain/repositories/contractor_home_repository.dart';

class GetContractorHomeDataUseCase {
  final ContractorHomeRepository repository;

  GetContractorHomeDataUseCase(this.repository);

  Future<ApiResult<ContractorHomeEntity>> call({
    required String contractorId,
  }) async {
    return await repository.getContractorHomeData(
      contractorId: contractorId,
    );
  }
}
