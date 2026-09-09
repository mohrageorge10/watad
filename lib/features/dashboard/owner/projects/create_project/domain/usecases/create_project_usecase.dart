
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/domain/entities/create_project_request.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/domain/repositories/create_project_repository.dart';

class CreateProjectUseCase {
  final CreateProjectRepository repository;

  CreateProjectUseCase(this.repository);

  Future<ApiResult<void>> call(CreateProjectRequest request) async {
    return await repository.createProject(request);
  }
}
