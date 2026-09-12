import 'package:dio/dio.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
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

      // 4. Map JSON response to ContractorProfileModel
      if (response is Map<String, dynamic>) {
        final dynamic data = response[ApiKey.data] ?? response;
        if (data is Map<String, dynamic>) {
          return ContractorProfileModel.fromJson(data);
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
    return ContractorProfileModel(
      id: cachedId,
      name: cachedName.isNotEmpty ? cachedName : 'Contractor',
      companyName: 'Company Details Pending',
      rating: 0.0,
      reviewsCount: 0,
      isVerified: false,
      yearsOfExperience: '0',
      projectsCompiled: '0',
      verificationStatus: 'Unverified',
      commercialRegister: '',
      taxCard: '',
      aboutMe: 'Tap Edit Profile to add company details, experience, and services.',
      specializations: const [],
      coveredGovernorates: const [],
      portfolioImages: const [],
      profileImagePath: null,
      isCompleted: false,
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
