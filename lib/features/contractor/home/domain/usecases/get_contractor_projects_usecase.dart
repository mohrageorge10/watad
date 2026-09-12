import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_project_entity.dart';
import 'package:watad/features/contractor/home/domain/entities/project_status.dart';
import 'package:watad/features/contractor/home/domain/repositories/contractor_projects_repository.dart';

class GetContractorProjectsUseCase {
  final ContractorProjectsRepository repository;

  GetContractorProjectsUseCase(this.repository);

  Future<ApiResult<List<ContractorProjectEntity>>> call({
    int? status,
    ProjectStatus? projectStatus,
  }) async {
    final statusValue = projectStatus?.value ?? status;
    return await repository.getContractorProjects(status: statusValue);
  }
}
