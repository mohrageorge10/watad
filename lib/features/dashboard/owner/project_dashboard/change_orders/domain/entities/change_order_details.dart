enum ChangeOrderReviewStatus { pending, approved, rejected }

class ChangeOrderDetails {
  final String id;
  final String description;
  final num costImpact;
  final int timeImpactDays;
  final DateTime createdAt;
  final ChangeOrderReviewStatus status;

  const ChangeOrderDetails({
    required this.id,
    required this.description,
    required this.costImpact,
    required this.timeImpactDays,
    required this.createdAt,
    required this.status,
  });
}
