import 'package:dio/dio.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/profile/data/mock/contractor_profile_mock_data.dart';
import 'package:watad/features/contractor/profile/data/models/contractor_profile_model.dart';

abstract class ContractorProfileRemoteDataSource {
  Future<ContractorProfileModel> fetchContractorProfile();

  Future<ContractorProfileModel> getContractorProfile({
    required String contractorId,
    String? userName,
  });

  Future<dynamic> updateContractorProfile({
    required Map<String, dynamic> profileData,
  });
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

      throw const FormatException('Invalid profile response structure');
    } on DioException {
      // Catch DioException (401 Unauthorized, timeout, network errors) gracefully
      rethrow;
    } catch (e) {
      rethrow;
    }
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
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    if (token != null && token.isNotEmpty) {
      return await fetchContractorProfile();
    }

    // Fallback for unauthenticated local development / testing
    await Future.delayed(const Duration(milliseconds: 600));
    return ContractorProfileMockData.getContractorProfile(
      contractorId: contractorId,
      userName: userName,
    );
  }
}
