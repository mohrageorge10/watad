import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_project_entity.dart';

abstract class ContractorProjectsRepository {
  Future<ApiResult<List<ContractorProjectEntity>>> getContractorProjects({
    int? status,
  });
}
