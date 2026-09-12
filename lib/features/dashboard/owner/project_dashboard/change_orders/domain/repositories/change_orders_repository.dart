import 'package:watad/core/network/api/api_result.dart';
import '../entities/change_order_summary_data.dart';

abstract class ChangeOrdersRepository {
  Future<ApiResult<ChangeOrderSummaryData>> getChangeOrders(String projectId);
}
