import 'package:watad/core/network/api/api_result.dart';
import '../entities/all_change_orders_data.dart';

abstract class AllChangeOrdersRepository {
  Future<ApiResult<AllChangeOrdersData>> getAllChangeOrders(String projectId);
}
