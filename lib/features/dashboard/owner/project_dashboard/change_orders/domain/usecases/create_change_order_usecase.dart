import 'package:watad/core/network/api/api_result.dart';
import '../repositories/change_orders_repository.dart';

class CreateChangeOrderUseCase {
  final ChangeOrdersRepository repository;

  CreateChangeOrderUseCase({required this.repository});

  Future<ApiResult<String>> call(String projectId, String description, num costImpact, int timeImpactDays) {
    return repository.createChangeOrder(projectId, description, costImpact, timeImpactDays);
  }
}
