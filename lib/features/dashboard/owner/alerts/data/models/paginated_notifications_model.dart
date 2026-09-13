import 'package:watad/features/dashboard/owner/alerts/domain/entities/paginated_notifications.dart';
import 'package:watad/features/dashboard/owner/alerts/data/models/notification_model.dart';

class PaginatedNotificationsModel extends PaginatedNotifications {
  const PaginatedNotificationsModel({
    required super.items,
    required super.currentPage,
    required super.totalPages,
    required super.pageSize,
    required super.totalCount,
    required super.hasPrevious,
    required super.hasNext,
  });

  factory PaginatedNotificationsModel.fromJson(Map<String, dynamic> json) {
    final rawItems = (json['items'] as List?) ?? const [];
    return PaginatedNotificationsModel(
      items: rawItems
          .map((e) => NotificationDto.fromJson(e as Map<String, dynamic>).toEntity())
          .toList(),
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 0,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      hasPrevious: json['hasPrevious'] as bool? ?? false,
      hasNext: json['hasNext'] as bool? ?? false,
    );
  }
}
