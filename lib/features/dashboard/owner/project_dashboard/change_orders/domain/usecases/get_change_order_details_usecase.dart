import 'package:watad/core/network/api/api_result.dart';
import '../entities/change_order_details.dart';
import '../repositories/change_orders_repository.dart';

class GetChangeOrderDetailsUsecase {
  final ChangeOrdersRepository repository;

  GetChangeOrderDetailsUsecase({required this.repository});

  Future<ApiResult<ChangeOrderDetails>> call(String id) {
    return repository.getChangeOrderDetails(id);
  }
}
