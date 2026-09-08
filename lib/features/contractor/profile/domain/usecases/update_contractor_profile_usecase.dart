import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/profile/domain/repositories/contractor_profile_repository.dart';

class UpdateContractorProfileUseCase {
  final ContractorProfileRepository repository;

  UpdateContractorProfileUseCase(this.repository);

  Future<ApiResult<void>> call({
    required Map<String, dynamic> profileData,
  }) async {
    return await repository.updateContractorProfile(
      profileData: profileData,
    );
  }
}
