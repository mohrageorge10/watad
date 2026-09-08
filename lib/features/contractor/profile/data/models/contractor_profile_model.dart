import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';

class ContractorProfileModel extends ContractorProfileEntity {
  const ContractorProfileModel({
    required super.id,
    required super.name,
    required super.companyName,
    required super.rating,
    required super.reviewsCount,
    required super.isVerified,
    required super.yearsOfExperience,
    required super.projectsCompiled,
    required super.verificationStatus,
    required super.commercialRegister,
    required super.taxCard,
    required super.aboutMe,
    required super.specializations,
    required super.coveredGovernorates,
    required super.portfolioImages,
    super.profileImagePath,
  });

  factory ContractorProfileModel.fromJson(Map<String, dynamic> json) {
    return ContractorProfileModel(
      id: json['id'] as String? ?? 'contractor_1',
      name: json['name'] as String? ?? 'Ahmed Khaled Hassan',
      companyName: json['companyName'] as String? ?? 'Delta Construction Co.',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.8,
      reviewsCount: json['reviewsCount'] as int? ?? 124,
      isVerified: json['isVerified'] as bool? ?? true,
      yearsOfExperience: json['yearsOfExperience'] as String? ?? '8+',
      projectsCompiled: json['projectsCompiled'] as String? ?? '15+',
      verificationStatus: json['verificationStatus'] as String? ?? '✓ Verified',
      commercialRegister: json['commercialRegister'] as String? ?? '123456789',
      taxCard: json['taxCard'] as String? ?? '987654321',
      aboutMe: json['aboutMe'] as String? ??
          'We are a leading construction company with extensive experience in residential and commercial projects. We are committed to delivering high-quality work, on time and within budget.',
      specializations: (json['specializations'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const ['Residential Construction'],
      coveredGovernorates: (json['coveredGovernorates'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const ['Cairo', 'Giza', 'Alexandria', '6th of October'],
      portfolioImages: (json['portfolioImages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [
            'portfolio_1.png',
            'portfolio_2.png',
            'portfolio_3.png',
            'portfolio_4.png',
          ],
      profileImagePath: json['profileImagePath'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'companyName': companyName,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'isVerified': isVerified,
      'yearsOfExperience': yearsOfExperience,
      'projectsCompiled': projectsCompiled,
      'verificationStatus': verificationStatus,
      'commercialRegister': commercialRegister,
      'taxCard': taxCard,
      'aboutMe': aboutMe,
      'specializations': specializations,
      'coveredGovernorates': coveredGovernorates,
      'portfolioImages': portfolioImages,
      'profileImagePath': profileImagePath,
    };
  }
}
