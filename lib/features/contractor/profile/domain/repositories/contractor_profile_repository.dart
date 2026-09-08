import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';

abstract class ContractorProfileRepository {
  Future<ApiResult<ContractorProfileEntity>> getContractorProfile({
    required String contractorId,
  });
}
