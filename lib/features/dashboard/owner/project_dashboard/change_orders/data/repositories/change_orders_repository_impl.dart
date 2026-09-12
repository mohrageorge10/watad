import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/errors/error_handler.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/change_order_summary_data.dart';
import '../../domain/entities/change_order_item.dart';
import '../../domain/repositories/change_orders_repository.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/domain/entities/change_order_details.dart';
import '../datasources/change_orders_remote_data_source.dart';

class ChangeOrdersRepositoryImpl implements ChangeOrdersRepository {
  final ChangeOrdersRemoteDataSource remoteDataSource;

  ChangeOrdersRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<ChangeOrderSummaryData>> getChangeOrders(String projectId) async {
    try {
      final response = await remoteDataSource.getChangeOrdersHistory(projectId);
      
      final dtoList = response.data ?? [];
      
      final formatCurrency = NumberFormat("#,##0.00", "en_US");
      
      final recentChangeOrders = dtoList.map((dto) {
        String formattedDate = dto.createdAt;
        try {
          if (dto.createdAt.isNotEmpty) {
            final parsedDate = DateTime.parse(dto.createdAt);
            formattedDate = DateFormat('MMM d, yyyy').format(parsedDate);
          }
        } catch (_) {}

        return ChangeOrderItem(
          id: dto.id,
          requestedByUserId: dto.requestedByUserId,
          description: dto.description,
          costImpact: '\$${formatCurrency.format(dto.costImpact)}',
          createdAt: formattedDate,
          status: dto.status,
        );
      }).toList();

      final summary = ChangeOrderSummaryData(
        recentChangeOrders: recentChangeOrders,
      );

      return ApiResult.success(summary);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<ChangeOrderDetails>> getChangeOrderDetails(String id) async {
    try {
      final response = await remoteDataSource.getChangeOrderDetails(id);
      return ApiResult.success(response.toEntity());
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<bool>> decideChangeOrder(String id, bool isApproved, String? rejectionReason) async {
    try {
      final result = await remoteDataSource.decideChangeOrder(id, isApproved, rejectionReason);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }

  @override
  Future<ApiResult<String>> createChangeOrder(String projectId, String description, num costImpact, int timeImpactDays) async {
    try {
      final result = await remoteDataSource.createChangeOrder(projectId, description, costImpact, timeImpactDays);
      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}

