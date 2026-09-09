import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/network/connection/network_info.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/data/datasources/create_project_remote_data_source.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/domain/entities/create_project_request.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/domain/repositories/create_project_repository.dart';

class CreateProjectRepositoryImpl implements CreateProjectRepository {
  final CreateProjectRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CreateProjectRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<ApiResult<void>> createProject(CreateProjectRequest request) async {
    if (await networkInfo.isConnected == true) {
      try {
        await remoteDataSource.createProject(request);
        return ApiResult.success(null);
      } catch (error) {
        return ApiResult.failure(ErrorHandler.handle(error));
      }
    } else {
      return ApiResult.failure(const NetworkFailure(errMessage: "No internet connection. Please check your network."));
    }
  }
}
