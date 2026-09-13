import 'package:dio/dio.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/profile/data/models/contractor_profile_model.dart';
import 'package:watad/features/contractor/profile/data/models/review_model.dart';

abstract class ContractorProfileRemoteDataSource {
  Future<ContractorProfileModel> fetchContractorProfile();

  Future<ContractorProfileModel> getContractorProfile({
    required String contractorId,
    String? userName,
  });

  Future<dynamic> updateContractorProfile({
    required Map<String, dynamic> profileData,
  });

  Future<List<ReviewModel>> fetchMyReviews();
}

class ContractorProfileRemoteDataSourceImpl
    implements ContractorProfileRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  ContractorProfileRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.secureStorage,
    required this.cacheHelper,
  });

  @override
  Future<ContractorProfileModel> fetchContractorProfile() async {
    try {
      // 1. Retrieve authentication token securely from local storage
      final token = await secureStorage.read(key: CacheKeys.token) ??
          (cacheHelper.getData(key: CacheKeys.token) as String?);

      // 2. Inject Bearer Token into headers
      final headers = <String, dynamic>{
        if (token != null && token.isNotEmpty)
          ApiKey.authorization: ApiKey.bearer(token),
      };

      // 3. Centralized endpoint call (GET /api/Contractor/profile)
      final response = await apiConsumer.get(
        EndPoints.contractorProfile,
        headers: headers,
      );

      List<PortfolioProjectItemModel> portfolioProjects = [];
      try {
        final portfolioResp = await apiConsumer.get(
          EndPoints.contractorPortfolio,
          headers: headers,
        );
        if (portfolioResp is List) {
          portfolioProjects = portfolioResp
              .map((item) =>
                  PortfolioProjectItemModel.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (portfolioResp is Map<String, dynamic>) {
          final dynamic pData = portfolioResp[ApiKey.data] ??
              portfolioResp['items'] ??
              portfolioResp['portfolio'] ??
              portfolioResp['portfolioItems'];
          if (pData is List) {
            portfolioProjects = pData
                .map((item) =>
                    PortfolioProjectItemModel.fromJson(item as Map<String, dynamic>))
                .toList();
          }
        }
      } catch (_) {}

      // 4. Map JSON response to ContractorProfileModel
      if (response is Map<String, dynamic>) {
        final dynamic data = response[ApiKey.data] ?? response;
        if (data is Map<String, dynamic>) {
          final profileModel = ContractorProfileModel.fromJson(data);

          // Merge projects from dedicated portfolio endpoint with profile summary
          final Map<String, PortfolioProjectItemModel> mergedProjects = {};
          for (final p in profileModel.portfolioProjects) {
            if (p.id.isNotEmpty) mergedProjects[p.id] = p;
          }
          for (final p in portfolioProjects) {
            if (p.id.isNotEmpty) mergedProjects[p.id] = p;
          }
          final List<PortfolioProjectItemModel> effectiveProjects =
              mergedProjects.isNotEmpty
                  ? mergedProjects.values.toList()
                  : (portfolioProjects.isNotEmpty
                      ? portfolioProjects
                      : profileModel.portfolioProjects);

          final cachedCompany =
              cacheHelper.getData(key: 'contractor_cached_company_name') as String?;
          final cachedCommercial =
              cacheHelper.getData(key: 'contractor_cached_commercial_register') as String?;
          final cachedTax =
              cacheHelper.getData(key: 'contractor_cached_tax_card') as String?;
          final cachedAbout =
              cacheHelper.getData(key: 'contractor_cached_about_me') as String?;
          final cachedIsComplete =
              cacheHelper.getData(key: 'contractor_is_profile_complete') == true;

          return ContractorProfileModel(
            id: profileModel.id,
            name: profileModel.name,
            companyName: (cachedCompany != null && cachedCompany.trim().isNotEmpty)
                ? cachedCompany.trim()
                : profileModel.companyName,
            rating: profileModel.rating,
            reviewsCount: profileModel.reviewsCount,
            isVerified: profileModel.isVerified,
            yearsOfExperience: profileModel.yearsOfExperience,
            projectsCompiled: effectiveProjects.isNotEmpty
                ? effectiveProjects.length.toString()
                : profileModel.projectsCompiled,
            verificationStatus: profileModel.verificationStatus,
            commercialRegister: (cachedCommercial != null && cachedCommercial.trim().isNotEmpty)
                ? cachedCommercial.trim()
                : profileModel.commercialRegister,
            taxCard: (cachedTax != null && cachedTax.trim().isNotEmpty)
                ? cachedTax.trim()
                : profileModel.taxCard,
            aboutMe: (cachedAbout != null && cachedAbout.trim().isNotEmpty)
                ? cachedAbout.trim()
                : profileModel.aboutMe,
            specializations: profileModel.specializations,
            coveredGovernorates: profileModel.coveredGovernorates,
            portfolioImages: profileModel.portfolioImages,
            portfolioProjects: effectiveProjects,
            profileImagePath: profileModel.profileImagePath,
            isCompleted: cachedIsComplete || profileModel.isCompleted == true,
          );
        }
      }

      return _createInitialProfile();
    } on DioException catch (e) {
      // If 404 or not found, return initial profile so new contractors can set up details
      if (e.response?.statusCode == 404) {
        return _createInitialProfile();
      }
      rethrow;
    } catch (_) {
      return _createInitialProfile();
    }
  }

  ContractorProfileModel _createInitialProfile() {
    final cachedName = (cacheHelper.getData(key: CacheKeys.userName) as String?) ?? 'Contractor';
    final cachedId = (cacheHelper.getData(key: CacheKeys.userId) as String?) ?? '';
    final cachedCompany =
        cacheHelper.getData(key: 'contractor_cached_company_name') as String?;
    final cachedAbout =
        cacheHelper.getData(key: 'contractor_cached_about_me') as String?;
    final cachedCommercial =
        cacheHelper.getData(key: 'contractor_cached_commercial_register') as String?;
    final cachedTax =
        cacheHelper.getData(key: 'contractor_cached_tax_card') as String?;
    final cachedIsComplete =
        cacheHelper.getData(key: 'contractor_is_profile_complete') == true;

    return ContractorProfileModel(
      id: cachedId,
      name: cachedName.isNotEmpty ? cachedName : 'Contractor',
      companyName: cachedCompany ?? '',
      rating: 0.0,
      reviewsCount: 0,
      isVerified: false,
      yearsOfExperience: '0',
      projectsCompiled: '0',
      verificationStatus: 'Unverified',
      commercialRegister: cachedCommercial ?? '',
      taxCard: cachedTax ?? '',
      aboutMe: cachedAbout ?? '',
      specializations: const [],
      coveredGovernorates: const [],
      portfolioImages: const [],
      profileImagePath: null,
      isCompleted: cachedIsComplete,
    );
  }

  @override
  Future<dynamic> updateContractorProfile({
    required Map<String, dynamic> profileData,
  }) async {
    try {
      // 1. Retrieve authentication token securely from local storage
      final token = await secureStorage.read(key: CacheKeys.token) ??
          (cacheHelper.getData(key: CacheKeys.token) as String?);

      // 2. Inject Bearer Token into headers
      final headers = <String, dynamic>{
        if (token != null && token.isNotEmpty)
          ApiKey.authorization: ApiKey.bearer(token),
      };

      // 3. Centralized endpoint call (PUT /api/Contractor/profile)
      final response = await apiConsumer.put(
        EndPoints.contractorProfile,
        data: profileData,
        headers: headers,
      );

      return response;
    } on DioException {
      // Catch validation errors (400 Bad Request) or 401 Unauthorized gracefully
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ContractorProfileModel> getContractorProfile({
    required String contractorId,
    String? userName,
  }) async {
    return await fetchContractorProfile();
  }

  @override
  Future<List<ReviewModel>> fetchMyReviews() async {
    try {
      final token = await secureStorage.read(key: CacheKeys.token) ??
          (cacheHelper.getData(key: CacheKeys.token) as String?);

      final headers = <String, dynamic>{
        if (token != null && token.isNotEmpty)
          ApiKey.authorization: ApiKey.bearer(token),
      };

      final response = await apiConsumer.get(
        EndPoints.myReviews,
        headers: headers,
      );

      if (response is List) {
        return response
            .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (response is Map<String, dynamic>) {
        final dynamic data =
            response[ApiKey.data] ?? response['reviews'] ?? response['items'];
        if (data is List) {
          return data
              .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }

      return const [];
    } on DioException {
      return const [];
    } catch (_) {
      return const [];
    }
  }
}
