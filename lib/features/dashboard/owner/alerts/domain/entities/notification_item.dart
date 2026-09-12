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
  final String title;
  final String message;
  final DateTime? createdAt;
  final NotificationType type;

  const NotificationItem({
    required this.title,
    required this.message,
    required this.createdAt,
    required this.type,
  });
}
