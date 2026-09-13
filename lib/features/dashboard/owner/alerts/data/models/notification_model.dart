import 'package:watad/features/dashboard/owner/alerts/domain/entities/notification_item.dart';

class NotificationDto {
  final String? id;
  final String? title;
  final String? message;
  final String? type;
  final String? category;
  final String? projectId;
  final String? actionUrl;
  final bool? isRead;
  final String? createdAt;

  const NotificationDto({
    this.id,
    this.title,
    this.message,
    this.type,
    this.category,
    this.projectId,
    this.actionUrl,
    this.isRead,
    this.createdAt,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      id: json['id'] as String?,
      title: json['title'] as String?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      projectId: json['projectId'] as String?,
      actionUrl: json['actionUrl'] as String?,
      isRead: json['isRead'] as bool?,
      createdAt: json['createdAt'] as String?,
    );
  }

  NotificationItem toEntity() {
    return NotificationItem(
      id: id ?? '',
      title: title ?? '',
      message: message ?? '',
      createdAt: createdAt != null ? DateTime.tryParse(createdAt!) : null,
      type: _mapType(type),
      category: category,
      actionUrl: actionUrl,
      isRead: isRead ?? false,
    );
  }

  NotificationType _mapType(String? typeStr) {
    switch (typeStr?.toLowerCase()) {
      case 'warning':
        return NotificationType.warning;
      case 'alert':
        return NotificationType.alert;
      case 'actionrequired':
        return NotificationType.actionRequired;
      case 'info':
      default:
        return NotificationType.info;
    }
  }
}
