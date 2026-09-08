import 'package:equatable/equatable.dart';

class ContractorProfileEntity extends Equatable {
  final String id;
  final String name;
  final String companyName;
  final double rating;
  final int reviewsCount;
  final bool isVerified;
  final String yearsOfExperience;
  final String projectsCompiled;
  final String verificationStatus;
  final String commercialRegister;
  final String taxCard;
  final String aboutMe;
  final List<String> specializations;
  final List<String> coveredGovernorates;
  final List<String> portfolioImages;
  final String? profileImagePath;

  const ContractorProfileEntity({
    required this.id,
    required this.name,
    required this.companyName,
    required this.rating,
    required this.reviewsCount,
    required this.isVerified,
    required this.yearsOfExperience,
    required this.projectsCompiled,
    required this.verificationStatus,
    required this.commercialRegister,
    required this.taxCard,
    required this.aboutMe,
    required this.specializations,
    required this.coveredGovernorates,
    required this.portfolioImages,
    this.profileImagePath,
  });

  ContractorProfileEntity copyWith({
    String? id,
    String? name,
    String? companyName,
    double? rating,
    int? reviewsCount,
    bool? isVerified,
    String? yearsOfExperience,
    String? projectsCompiled,
    String? verificationStatus,
    String? commercialRegister,
    String? taxCard,
    String? aboutMe,
    List<String>? specializations,
    List<String>? coveredGovernorates,
    List<String>? portfolioImages,
    String? profileImagePath,
    bool clearProfileImage = false,
  }) {
    return ContractorProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      companyName: companyName ?? this.companyName,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      isVerified: isVerified ?? this.isVerified,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      projectsCompiled: projectsCompiled ?? this.projectsCompiled,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      commercialRegister: commercialRegister ?? this.commercialRegister,
      taxCard: taxCard ?? this.taxCard,
      aboutMe: aboutMe ?? this.aboutMe,
      specializations: specializations ?? this.specializations,
      coveredGovernorates: coveredGovernorates ?? this.coveredGovernorates,
      portfolioImages: portfolioImages ?? this.portfolioImages,
      profileImagePath: clearProfileImage
          ? null
          : (profileImagePath ?? this.profileImagePath),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        companyName,
        rating,
        reviewsCount,
        isVerified,
        yearsOfExperience,
        projectsCompiled,
        verificationStatus,
        commercialRegister,
        taxCard,
        aboutMe,
        specializations,
        coveredGovernorates,
        portfolioImages,
        profileImagePath,
      ];
}
