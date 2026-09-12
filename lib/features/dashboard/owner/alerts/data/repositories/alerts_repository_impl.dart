import 'package:watad/core/errors/exceptions.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/alerts/data/datasources/alerts_remote_data_source.dart';
import 'package:watad/features/dashboard/owner/alerts/domain/entities/paginated_notifications.dart';
import 'package:watad/features/dashboard/owner/alerts/domain/repositories/alerts_repository.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  final AlertsRemoteDataSource remoteDataSource;

  const AlertsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<PaginatedNotifications>> getNotifications({
    required int pageNumber,
    required int pageSize,
    String? category,
    String? type,
  }) async {
    try {
      final response = await remoteDataSource.getNotifications(
        pageNumber: pageNumber,
        pageSize: pageSize,
        category: category,
        type: type,
      );
      return ApiResult.success(response);
    } on ServerException catch (e) {
      return ApiResult.failure(ServerFailure(errMessage: e.errorModel.errorMessage));
    } catch (e) {
      return ApiResult.failure(ServerFailure(errMessage: e.toString()));
    }
  }
}
