import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/alerts/domain/entities/paginated_notifications.dart';
import 'package:watad/features/dashboard/owner/alerts/domain/repositories/alerts_repository.dart';

class GetNotificationsUseCase {
  final AlertsRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<ApiResult<PaginatedNotifications>> call({
    required int pageNumber,
    required int pageSize,
    String? category,
    String? type,
  }) async {
    return await repository.getNotifications(
      pageNumber: pageNumber,
      pageSize: pageSize,
      category: category,
      type: type,
    );
  }
}
