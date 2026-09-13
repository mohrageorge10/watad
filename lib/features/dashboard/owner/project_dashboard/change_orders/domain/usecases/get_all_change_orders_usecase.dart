import 'package:watad/core/network/api/api_result.dart';
import '../entities/all_change_orders_data.dart';
import '../repositories/all_change_orders_repository.dart';

class GetAllChangeOrdersUseCase {
  final AllChangeOrdersRepository _repository;

  GetAllChangeOrdersUseCase(this._repository);

  Future<ApiResult<AllChangeOrdersData>> call(String projectId) {
    return _repository.getAllChangeOrders(projectId);
  }
}
