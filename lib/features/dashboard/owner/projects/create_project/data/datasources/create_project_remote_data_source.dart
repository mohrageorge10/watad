import 'package:watad/core/errors/error_model.dart';
import 'package:watad/core/errors/exceptions.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/domain/entities/create_project_request.dart';

abstract class CreateProjectRemoteDataSource {
  Future<void> createProject(CreateProjectRequest request);
}

class CreateProjectRemoteDataSourceImpl implements CreateProjectRemoteDataSource {
  final ApiConsumer apiConsumer;

  CreateProjectRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<void> createProject(CreateProjectRequest request) async {
    final response = await apiConsumer.post(
      EndPoints.ownerProjects,
      data: request.toJson(),
    );

    final map = response as Map<String, dynamic>;
    final isSuccess = map['isSuccess'] as bool? ?? false;
    if (!isSuccess) {
      throw ServerException(ErrorModel.fromJson(map));
    }
  }
}
