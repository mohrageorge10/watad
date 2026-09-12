import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_home_entity.dart';

abstract class ContractorHomeRepository {
  Future<ApiResult<ContractorHomeEntity>> getContractorHomeData({
    required String contractorId,
  });
}
