import '../../domain/entities/alert_item.dart';

class MockAlertsRepository {
  Future<AlertsData> getAlerts() async {
    await Future.delayed(const Duration(milliseconds: 600));

    return AlertsData(
      todayAlerts: [
        AlertItem(
          id: '1',
          type: AlertType.critical,
          title: 'Concrete strength below required level',
          subtitle: '',
          dateText: 'Today, 08:30 AM',
          isUnread: true,
        ),
        AlertItem(
          id: '2',
          type: AlertType.warning,
          title: 'Delay in concrete pour – Zone B',
          subtitle: '',
          dateText: 'Today, 07:15 AM',
          isUnread: true,
        ),
        AlertItem(
          id: '3',
          type: AlertType.info,
          title: 'Inspection scheduled for tomorrow',
          subtitle: '',
          dateText: 'Yesterday, 05:20 PM',
          isUnread: true,
        ),
      ],
      earlierAlerts: [
        AlertItem(
          id: '4',
          type: AlertType.success,
          title: 'Payment received',
          subtitle: 'Payment #3 has been processed',
          dateText: '16 May 2024 – 02:45 PM',
        ),
        AlertItem(
          id: '5',
          type: AlertType.info,
          title: 'New daily report added',
          subtitle: 'Daily report for 16 May',
          dateText: '16 May 2024 – 08:10 AM',
        ),
        AlertItem(
          id: '6',
          type: AlertType.success,
          title: 'Change order approved',
          subtitle: 'CO-02 has been approved',
          dateText: '15 May 2024 – 04:30 PM',
        ),
      ],
    );
  }
}
