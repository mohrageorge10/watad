import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/errors/error_handler.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/change_order_summary_data.dart';
import '../../domain/entities/change_order_item.dart';
import '../../domain/repositories/change_orders_repository.dart';
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
}
