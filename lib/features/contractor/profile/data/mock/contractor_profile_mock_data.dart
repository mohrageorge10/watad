import 'package:watad/features/contractor/profile/data/models/contractor_profile_model.dart';

class ContractorProfileMockData {
  ContractorProfileMockData._();

  static bool forceEmptyState = false;

  static ContractorProfileModel getContractorProfile({
    required String contractorId,
    String? userName,
  }) {
    if (forceEmptyState) {
      return ContractorProfileModel(
        id: contractorId,
        name: userName ?? 'Ahmed Khaled Hassan',
        companyName: 'Delta Construction Co.',
        rating: 0.0,
        reviewsCount: 0,
        isVerified: false,
        yearsOfExperience: '0',
        projectsCompiled: '0',
        verificationStatus: 'Pending',
        commercialRegister: '-',
        taxCard: '-',
        aboutMe: 'No description provided yet.',
        specializations: const [],
        coveredGovernorates: const [],
        portfolioImages: const [],
      );
    }

    return ContractorProfileModel(
      id: contractorId,
      name: userName ?? 'Ahmed Khaled Hassan',
      companyName: 'Delta Construction Co.',
      rating: 4.8,
      reviewsCount: 124,
      isVerified: true,
      yearsOfExperience: '8+',
      projectsCompiled: '15+',
      verificationStatus: '✓ Verified',
      commercialRegister: '123456789',
      taxCard: '987654321',
      aboutMe:
          'We are a leading construction company with extensive experience in residential and commercial projects. We are committed to delivering high-quality work, on time and within budget.',
      specializations: const [
        'Residential Construction',
      ],
      coveredGovernorates: const [
        'Cairo',
        'Giza',
        'Alexandria',
        '6th of October',
      ],
      portfolioImages: const [
        'portfolio_1.png',
        'portfolio_2.png',
        'portfolio_3.png',
        'portfolio_4.png',
      ],
    );
  }
}
