import 'change_order_details.dart';

class ChangeOrdersStats {
  final int pendingCount;
  final num pendingCostImpact;
  final int pendingDaysImpact;
  final int totalOrders;

  const ChangeOrdersStats({
    required this.pendingCount,
    required this.pendingCostImpact,
    required this.pendingDaysImpact,
    required this.totalOrders,
  });
}

class AllChangeOrdersData {
  final ChangeOrdersStats stats;
  final List<ChangeOrderDetails> pendingOrders;

  const AllChangeOrdersData({
    required this.stats,
    required this.pendingOrders,
  });
}
