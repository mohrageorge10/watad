import 'package:watad/core/errors/exceptions.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/domain/entities/all_change_orders_data.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/domain/repositories/all_change_orders_repository.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/data/datasources/all_change_orders_remote_data_source.dart';

class AllChangeOrdersRepositoryImpl implements AllChangeOrdersRepository {
  final AllChangeOrdersRemoteDataSource remoteDataSource;

  AllChangeOrdersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<AllChangeOrdersData>> getAllChangeOrders(String projectId) async {
    try {
      final pendingDtos = await remoteDataSource.getPendingChangeOrders(projectId);
      
      // The instructions require keeping the first four summary containers (stats) STATIC UI exactly as shown in the screenshot.
      // We populate these with static mock values.
      const staticStats = ChangeOrdersStats(
        pendingCount: 1,
        pendingCostImpact: 20000.0,
        pendingDaysImpact: 45,
        totalOrders: 3,
      );

      final data = AllChangeOrdersData(
        stats: staticStats,
        pendingOrders: pendingDtos.map((dto) => dto.toEntity()).toList(),
      );

      return ApiResult.success(data);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
