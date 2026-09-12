import 'package:dio/dio.dart';
import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/milestone_inspection/data/datasources/milestone_inspection_remote_data_source.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/entities/milestone_inspection_details_entity.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/repositories/milestone_inspection_repository.dart';

class MilestoneInspectionRepositoryImpl implements MilestoneInspectionRepository {
  final MilestoneInspectionRemoteDataSource remoteDataSource;

  MilestoneInspectionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<MilestoneInspectionDetailsEntity>> getMilestoneInspectionDetails({
    required String milestoneId,
  }) async {
    try {
      final result = await remoteDataSource.getMilestoneInspectionDetails(milestoneId);
      return ApiResult.success(result);
    } catch (e) {
      if (e is DioException) {
        return ApiResult.failure(ErrorHandler.handle(e));
      }
      return ApiResult.failure(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<ApiResult<bool>> submitMilestoneInspectionRequest({
    required String milestoneId,
    String? notes,
  }) async {
    try {
      final result = await remoteDataSource.submitMilestoneInspectionRequest(
        milestoneId: milestoneId,
        notes: notes,
      );
      return ApiResult.success(result);
    } catch (e) {
      if (e is DioException) {
        return ApiResult.failure(ErrorHandler.handle(e));
      }
      return ApiResult.failure(ServerFailure(errMessage: e.toString()));
    }
  }
}
