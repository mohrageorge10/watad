import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/alerts/domain/entities/paginated_notifications.dart';

abstract class AlertsRepository {
  Future<ApiResult<PaginatedNotifications>> getNotifications({
    required int pageNumber,
    required int pageSize,
    String? category,
    String? type,
  });
}
