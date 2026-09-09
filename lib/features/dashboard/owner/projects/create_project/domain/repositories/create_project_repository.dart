
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/domain/entities/create_project_request.dart';

abstract class CreateProjectRepository {
  Future<ApiResult<void>> createProject(CreateProjectRequest request);
}
