import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/network/connection/network_info.dart';
import 'package:watad/features/dashboard/owner/feasibility/data/datasources/feasibility_remote_data_source.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_request.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/repositories/feasibility_repository.dart';

class FeasibilityRepositoryImpl implements FeasibilityRepository {
  final FeasibilityRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const FeasibilityRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<ApiResult<FeasibilityReport>> calculateFeasibility(FeasibilityRequest request) async {
    if (await networkInfo.isConnected == true) {
      try {
        final result = await remoteDataSource.calculateFeasibility(request);
        return ApiResult.success(result);
      } catch (error) {
        return ApiResult.failure(ErrorHandler.handle(error));
      }
    } else {
      return ApiResult.failure(const NetworkFailure());
    }
  }

  @override
  Future<ApiResult<void>> saveFeasibility(String reportId, String newProjectTitle) async {
    if (await networkInfo.isConnected == true) {
      try {
        await remoteDataSource.saveFeasibility(reportId, newProjectTitle);
        return ApiResult.success(null);
      } catch (error) {
        return ApiResult.failure(ErrorHandler.handle(error));
      }
    } else {
      return ApiResult.failure(const NetworkFailure());
    }
  }
}
