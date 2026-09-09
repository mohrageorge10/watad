import 'change_order_item.dart';

class ChangeOrderSummaryData {
  final String projectName;
  final int pendingCount;
  final String pendingAmount;
  final String eotDays;
  final String eotAmount;
  final List<ChangeOrderItem> recentChangeOrders;

  ChangeOrderSummaryData({
    required this.projectName,
    required this.pendingCount,
    required this.pendingAmount,
    required this.eotDays,
    required this.eotAmount,
    required this.recentChangeOrders,
  });
}
