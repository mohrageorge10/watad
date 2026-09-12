import 'package:watad/core/network/api/api_result.dart';
import '../repositories/change_orders_repository.dart';

class DecideChangeOrderUsecase {
  final ChangeOrdersRepository repository;

  DecideChangeOrderUsecase({required this.repository});

  Future<ApiResult<bool>> call(String id, bool isApproved, String? rejectionReason) {
    return repository.decideChangeOrder(id, isApproved, rejectionReason);
  }
}
