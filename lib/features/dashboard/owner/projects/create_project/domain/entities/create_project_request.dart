class CreateProjectRequest {
  final String title;
  final double landArea;
  final int floorsCount;
  final String governorate;
  final String city;
  final double latitude;
  final double longitude;
  final int finishingLevel;
  final double estimatedBudget;
  final String expectedStartDate;
  final int expectedDurationMonths;

  CreateProjectRequest({
    required this.title,
    required this.landArea,
    required this.floorsCount,
    required this.governorate,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.finishingLevel,
    required this.estimatedBudget,
    required this.expectedStartDate,
    required this.expectedDurationMonths,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "landArea": landArea,
      "floorsCount": floorsCount,
      "governorate": governorate,
      "city": city,
      "latitude": latitude,
      "longitude": longitude,
      "finishingLevel": finishingLevel,
      "estimatedBudget": estimatedBudget,
      "expectedStartDate": expectedStartDate,
      "expectedDurationMonths": expectedDurationMonths,
    };
  }
}
