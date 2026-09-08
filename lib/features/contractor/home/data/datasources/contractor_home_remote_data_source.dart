import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/bids/data/datasources/contractor_bids_remote_data_source.dart';
import 'package:watad/features/contractor/home/data/datasources/contractor_projects_remote_data_source.dart';
import 'package:watad/features/contractor/home/data/mock/contractor_home_mock_data.dart';
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

    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    // 1. If user is authenticated with a token, fetch REAL data from API
    if (token != null && token.isNotEmpty) {
      try {
        final projectsFuture =
            projectsRemoteDataSource.fetchContractorProjects();
        final bidsFuture = bidsRemoteDataSource.fetchContractorBids(
          pageNumber: 1,
          pageSize: 5,
        );
        final profileFuture =
            profileRemoteDataSource.fetchContractorProfile().then<ContractorProfileModel?>(
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

        final isProfileComplete = profile?.isProfileComplete ?? false;
        final displayName = (profile != null && profile.name.isNotEmpty)
            ? profile.name
            : ((profile != null && profile.companyName.isNotEmpty)
                ? profile.companyName
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
      } catch (e) {
        // If critical API call throws, rethrow to trigger ErrorHandler & Error State
        rethrow;
      }
    }

    // 2. Fallback for unauthenticated local development / testing
    await Future.delayed(const Duration(milliseconds: 600));
    return ContractorHomeMockData.getHomeDataForContractor(
      contractorId: contractorId,
      userName: userName,
    );
  }
}
