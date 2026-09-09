enum AlertType {
  critical,
  warning,
  info,
  success,
}

class AlertItem {
  final String id;
  final AlertType type;
  final String title;
  final String subtitle;
  final String dateText;
  final bool isUnread;

  AlertItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.dateText,
    this.isUnread = false,
  });
}

class AlertsData {
  final List<AlertItem> todayAlerts;
  final List<AlertItem> earlierAlerts;

  AlertsData({
    required this.todayAlerts,
    required this.earlierAlerts,
  });
}
