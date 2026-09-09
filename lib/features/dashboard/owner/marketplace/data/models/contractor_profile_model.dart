import 'package:watad/features/dashboard/owner/marketplace/domain/entities/contractor_profile.dart';

class ContractorProfileModel extends ContractorProfile {
  const ContractorProfileModel({
    required super.id,
    required super.name,
    required super.coveredGovernorates,
    required super.rating,
    required super.matchPercentage,
    required super.imageUrl,
    required super.reviewsCount,
    required super.specialization,
    required super.yearsOfExperience,
  });

  factory ContractorProfileModel.fromJson(Map<String, dynamic> json) {
    return ContractorProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['companyName'] ?? json['fullName'] ?? '',
      coveredGovernorates: json['coveredGovernorates']?.toString() ?? '',
      rating: (json['ratingAverage'] as num?)?.toDouble() ?? 0.0,
      matchPercentage: (json['matchPercentage'] as num?)?.toInt() ?? 0,
      imageUrl: json['imageUrl'] ?? '',
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      specialization: json['specialization']?.toString() ?? '',
      yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt() ?? 0,
    );
  }
}
