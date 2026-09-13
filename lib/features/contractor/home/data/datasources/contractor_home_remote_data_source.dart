import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/bids/data/datasources/contractor_bids_remote_data_source.dart';
import 'package:watad/features/contractor/home/data/datasources/contractor_projects_remote_data_source.dart';
import 'package:watad/features/contractor/home/data/models/contractor_home_model.dart';
import 'package:watad/features/contractor/home/data/models/contractor_project_model.dart';
import 'package:watad/features/contractor/home/data/models/contractor_bid_model.dart';
import 'package:watad/features/contractor/profile/data/datasources/contractor_profile_remote_data_source.dart';
import 'package:watad/features/contractor/profile/data/models/contractor_profile_model.dart';

abstract class ContractorHomeRemoteDataSource {
  Future<ContractorHomeModel> getContractorHomeData({
    required String contractorId,
    String? userName,
  });
}

class ContractorHomeRemoteDataSourceImpl
    implements ContractorHomeRemoteDataSource {
  final ApiConsumer apiConsumer;
  final ContractorProjectsRemoteDataSource projectsRemoteDataSource;
  final ContractorBidsRemoteDataSource bidsRemoteDataSource;
  final ContractorProfileRemoteDataSource profileRemoteDataSource;
  final CacheHelper cacheHelper;
  final SecureStorageHelper secureStorage;

  ContractorHomeRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.projectsRemoteDataSource,
    required this.bidsRemoteDataSource,
    required this.profileRemoteDataSource,
    required this.cacheHelper,
    required this.secureStorage,
  });

  @override
  Future<ContractorHomeModel> getContractorHomeData({
    required String contractorId,
    String? userName,
  }) async {
    final cachedName = userName ??
        (cacheHelper.getData(key: CacheKeys.userName) as String?) ??
        'Contractor';

    final projectsFuture = projectsRemoteDataSource
        .fetchContractorProjects()
        .catchError((_) => <ContractorProjectModel>[]);
    final bidsFuture = bidsRemoteDataSource
        .fetchContractorBids(
          pageNumber: 1,
          pageSize: 5,
        )
        .catchError((_) => <ContractorBidModel>[]);
    final profileFuture = profileRemoteDataSource
        .fetchContractorProfile()
        .then<ContractorProfileModel?>(
          (p) => p,
          onError: (_) => null,
        );

    final results = await Future.wait([
      projectsFuture,
      bidsFuture,
      profileFuture,
    ]);

    final projects = results[0] as List<ContractorProjectModel>;
    final bids = results[1] as List<ContractorBidModel>;
    final profile = results[2] as ContractorProfileModel?;

    final cachedIsComplete =
        cacheHelper.getData(key: 'contractor_is_profile_complete') == true;
    final cachedCompany =
        cacheHelper.getData(key: 'contractor_cached_company_name') as String?;
    final cachedAbout =
        cacheHelper.getData(key: 'contractor_cached_about_me') as String?;
    final cachedCommercial =
        cacheHelper.getData(key: 'contractor_cached_commercial_register') as String?;
    final cachedTax =
        cacheHelper.getData(key: 'contractor_cached_tax_card') as String?;

    final effectiveCompanyName = (profile != null && profile.companyName.trim().isNotEmpty)
        ? profile.companyName.trim()
        : (cachedCompany?.trim() ?? '');

    final effectiveAboutMe = (profile != null && profile.aboutMe.trim().isNotEmpty)
        ? profile.aboutMe.trim()
        : (cachedAbout?.trim() ?? '');

    final effectiveCommercial = (profile != null && profile.commercialRegister.trim().isNotEmpty)
        ? profile.commercialRegister.trim()
        : (cachedCommercial?.trim() ?? '');

    final effectiveTax = (profile != null && profile.taxCard.trim().isNotEmpty)
        ? profile.taxCard.trim()
        : (cachedTax?.trim() ?? '');

    final hasCompany = effectiveCompanyName.isNotEmpty;
    final hasDetails = (effectiveAboutMe.isNotEmpty && !effectiveAboutMe.contains('Tap Edit Profile')) ||
        (effectiveCommercial.isNotEmpty && effectiveCommercial != '-') ||
        (effectiveTax.isNotEmpty && effectiveTax != '-') ||
        (profile?.specializations.isNotEmpty ?? false) ||
        (profile?.portfolioProjects.isNotEmpty ?? false);

    final isProfileComplete = cachedIsComplete ||
        (hasCompany && hasDetails) ||
        (profile?.isProfileComplete ?? false);

    final displayName = (profile != null && profile.name.isNotEmpty)
        ? profile.name
        : (effectiveCompanyName.isNotEmpty
            ? effectiveCompanyName
            : cachedName);

    return ContractorHomeModel(
      userName: displayName,
      headline: 'Your operational command center. Everything',
      completeProfileText:
          'Complete Your Company details and portfolio to increase your chances of getting accepted by 80%',
      ongoingProjectsCount: projects.length,
      activeProjects: projects,
      recentBids: bids,
      isProfileComplete: isProfileComplete,
    );
  }
}
