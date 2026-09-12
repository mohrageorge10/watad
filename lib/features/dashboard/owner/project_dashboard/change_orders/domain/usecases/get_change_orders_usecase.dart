import 'package:watad/core/network/api/api_result.dart';
import '../entities/change_order_summary_data.dart';
import '../repositories/change_orders_repository.dart';

class GetChangeOrdersUseCase {
  final ChangeOrdersRepository repository;

  GetChangeOrdersUseCase(this.repository);

  Future<ApiResult<ChangeOrderSummaryData>> call(String projectId) {
    return repository.getChangeOrders(projectId);
  }
}
