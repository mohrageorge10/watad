import 'package:dio/dio.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/marketplace/data/models/marketplace_project_details_model.dart';
import 'package:watad/features/contractor/marketplace/data/models/marketplace_project_model.dart';

abstract class MarketplaceRemoteDataSource {
  Future<List<MarketplaceProjectModel>> getMarketplaceProjects({
    String? category,
    String? searchQuery,
    String? governorate,
    int? minBudget,
    int? maxBudget,
    bool useRecommended = false,
  });

  Future<MarketplaceProjectDetailsModel> getMarketplaceProjectDetails(String id);
}

class MarketplaceRemoteDataSourceImpl implements MarketplaceRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  MarketplaceRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.secureStorage,
    required this.cacheHelper,
  });

  Future<Map<String, dynamic>> _getAuthHeaders() async {
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    return <String, dynamic>{
      if (token != null && token.isNotEmpty)
        ApiKey.authorization: ApiKey.bearer(token),
    };
  }

  @override
  Future<List<MarketplaceProjectModel>> getMarketplaceProjects({
    String? category,
    String? searchQuery,
    String? governorate,
    int? minBudget,
    int? maxBudget,
    bool useRecommended = false,
  }) async {
    try {
      final headers = await _getAuthHeaders();
      final queryParams = <String, dynamic>{};

      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        queryParams[ApiQueryParams.search] = searchQuery.trim();
      }

      final effectiveGov = governorate ??
          (category != null && (category == 'Cairo' || category == 'Giza')
              ? category
              : null);
      if (effectiveGov != null) {
        queryParams[ApiQueryParams.governorate] = effectiveGov;
      }

      if (minBudget != null) {
        queryParams[ApiQueryParams.minBudget] = minBudget;
      }
      if (maxBudget != null) {
        queryParams[ApiQueryParams.maxBudget] = maxBudget;
      }

      final endpoint = (useRecommended || (category == null || category == 'All'))
          ? EndPoints.contractorRecommendedProjects
          : EndPoints.projects;

      final response = await apiConsumer.get(
        endpoint,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
        headers: headers.isNotEmpty ? headers : null,
      );

      List<dynamic>? rawList;
      if (response is List) {
        rawList = response;
      } else if (response is Map<String, dynamic>) {
        final dynamic data = response[ApiKey.data] ?? response['projects'] ?? response['items'];
        if (data is List) {
          rawList = data;
        }
      }

      if (rawList != null) {
        return rawList
            .map((item) =>
                MarketplaceProjectModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      return const [];
    } on DioException {
      return const [];
    } catch (_) {
      return const [];
    }
  }

  @override
  Future<MarketplaceProjectDetailsModel> getMarketplaceProjectDetails(
      String id) async {
    final headers = await _getAuthHeaders();
    final response = await apiConsumer.get(
      EndPoints.projectDetails(id),
      headers: headers.isNotEmpty ? headers : null,
    );

    Map<String, dynamic>? dataMap;
    if (response is Map<String, dynamic>) {
      if (response.containsKey(ApiKey.data) &&
          response[ApiKey.data] is Map<String, dynamic>) {
        dataMap = response[ApiKey.data] as Map<String, dynamic>;
      } else {
        dataMap = response;
      }
    }

    if (dataMap != null && dataMap.isNotEmpty) {
      return MarketplaceProjectDetailsModel.fromJson(dataMap);
    }

    throw const FormatException('Project details not found');
  }
}
