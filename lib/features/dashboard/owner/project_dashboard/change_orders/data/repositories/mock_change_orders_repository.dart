import '../../domain/entities/change_order_item.dart';
import '../../domain/entities/change_order_summary_data.dart';

class MockChangeOrdersRepository {
  Future<ChangeOrderSummaryData> getChangeOrders() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    return ChangeOrderSummaryData(
      projectName: "Villa – New Cairo",
      pendingCount: 2,
      pendingAmount: "+145,000 EGP",
      eotDays: "+15 Days",
      eotAmount: "+0 EGP",
      recentChangeOrders: [
        ChangeOrderItem(
          id: "CO-04",
          title: "Additional Reinforcement",
          amount: "+45,000 EGP",
          date: "18 May 2024",
          status: ChangeOrderStatus.review,
        ),
        ChangeOrderItem(
          id: "CO-03",
          title: "Design Adjustment - Gate",
          amount: "+60,000 EGP",
          date: "10 May 2024",
          status: ChangeOrderStatus.approved,
        ),
        ChangeOrderItem(
          id: "CO-02",
          title: "Extra Excavation",
          amount: "+25,000 EGP",
          date: "02 May 2024",
          status: ChangeOrderStatus.approved,
        ),
        ChangeOrderItem(
          id: "CO-01",
          title: "Soil Treatment",
          amount: "+15,000 EGP",
          date: "20 Apr 2024",
          status: ChangeOrderStatus.approved,
        ),
      ],
    );
  }
}
