import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/domain/repositories/contractor_profile_repository.dart';

class GetContractorProfileUseCase {
  final ContractorProfileRepository repository;

  GetContractorProfileUseCase(this.repository);

  Future<ApiResult<ContractorProfileEntity>> call({
    required String contractorId,
  }) async {
    return await repository.getContractorProfile(
      contractorId: contractorId,
    );
  }
}
