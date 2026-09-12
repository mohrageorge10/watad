enum NotificationType {
  info,
  warning,
  alert,
  actionRequired,
}

enum NotificationCategory {
  general,
  qualityAndRisk,
  schedule,
  materialAndWaste,
  changeOrder,
  siteLog,
  inspection,
  financial,
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime? createdAt;
  final NotificationType type;
  final String? category;
  final String? actionUrl;
  final bool isRead;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.type,
    this.category,
    this.actionUrl,
    this.isRead = false,
  });
}
