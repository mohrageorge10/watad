class FeasibilityRequest {
  final double landArea;
  final int floorsCount;
  final int finishingLevel;
  final String governorate;
  final String city;
  final double latitude;
  final double longitude;

  const FeasibilityRequest({
    required this.landArea,
    required this.floorsCount,
    required this.finishingLevel,
    required this.governorate,
    required this.city,
    required this.latitude,
    required this.longitude,
  });
}
