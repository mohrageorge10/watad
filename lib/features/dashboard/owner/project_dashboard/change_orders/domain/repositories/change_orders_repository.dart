import 'package:watad/core/network/api/api_result.dart';
import '../entities/change_order_summary_data.dart';
import '../entities/change_order_details.dart';

abstract class ChangeOrdersRepository {
  Future<ApiResult<ChangeOrderSummaryData>> getChangeOrders(String projectId);
  Future<ApiResult<ChangeOrderDetails>> getChangeOrderDetails(String id);
  Future<ApiResult<bool>> decideChangeOrder(String id, bool isApproved, String? rejectionReason);
  Future<ApiResult<String>> createChangeOrder(String projectId, String description, num costImpact, int timeImpactDays);
}
