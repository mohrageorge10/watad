enum ChangeOrderStatus { review, approved, rejected }

class ChangeOrderItem {
  final String id;
  final String title;
  final String amount;
  final String date;
  final ChangeOrderStatus status;

  ChangeOrderItem({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
  });
}
