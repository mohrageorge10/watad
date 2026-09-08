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
    super.isCompleted,
  });

  factory ContractorProfileModel.fromJson(Map<String, dynamic> json) {
    return ContractorProfileModel(
      id: json['id']?.toString() ?? json['userId']?.toString() ?? '',
      name: json['name'] as String? ?? json['fullName'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: json['reviewsCount'] as int? ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
      yearsOfExperience: json['yearsOfExperience']?.toString() ?? '',
      projectsCompiled: json['projectsCompiled']?.toString() ??
          json['completedProjectsCount']?.toString() ??
          '0',
      verificationStatus: json['verificationStatus'] as String? ?? '',
      commercialRegister: json['commercialRegister'] as String? ??
          json['commercialRegistrationNumber'] as String? ??
          '',
      taxCard: json['taxCard'] as String? ?? json['taxNumber'] as String? ?? '',
      aboutMe: json['aboutMe'] as String? ??
          json['bio'] as String? ??
          json['description'] as String? ??
          '',
      specializations: (json['specializations'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      coveredGovernorates: (json['coveredGovernorates'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      portfolioImages: (json['portfolioImages'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      profileImagePath: json['profileImagePath'] as String? ??
          json['profileImage'] as String? ??
          json['imageUrl'] as String?,
      isCompleted: json['isCompleted'] as bool? ??
          json['isProfileCompleted'] as bool? ??
          json['isProfileComplete'] as bool?,
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
      'isCompleted': isCompleted,
    };
  }
}
