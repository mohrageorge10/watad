class ChangeOrderItem {
  final String id;
  final String requestedByUserId;
  final String costImpact;
  final String createdAt;
  final String status;

  ChangeOrderItem({
    required this.id,
    required this.requestedByUserId,
    required this.costImpact,
    required this.createdAt,
    required this.status,
  });
}
