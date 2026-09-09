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
      rating: (json['ratingAverage'] as num?)?.toDouble() ??
          (json['rating'] as num?)?.toDouble() ??
          0.0,
      reviewsCount: json['reviewsCount'] as int? ?? 0,
      isVerified: json['isVerified'] as bool? ??
          (json['verificationStatus']?.toString().toLowerCase() == 'verified'),
      yearsOfExperience: json['yearsOfExperience']?.toString() ?? '',
      projectsCompiled: json['projectsCompiled']?.toString() ??
          json['completedProjectsCount']?.toString() ??
          '0',
      verificationStatus: json['verificationStatus'] as String? ?? '',
      commercialRegister: json['commercialRegister'] as String? ??
          json['commercialRegistrationNumber'] as String? ??
          '',
      taxCard: json['taxCard'] as String? ?? json['taxNumber'] as String? ?? '',
      aboutMe: json['bio'] as String? ??
          json['aboutMe'] as String? ??
          json['description'] as String? ??
          '',
      specializations: _parseListOrDelimitedString(
          json['specialization'] ?? json['specializations']),
      coveredGovernorates:
          _parseListOrDelimitedString(json['coveredGovernorates']),
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

  static List<String> _parseListOrDelimitedString(dynamic value) {
    if (value is List) {
      return value
          .map((e) => e.toString().trim())
          .where((e) => e.isNotEmpty)
          .toList();
    } else if (value is String && value.isNotEmpty) {
      return value
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return const [];
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
