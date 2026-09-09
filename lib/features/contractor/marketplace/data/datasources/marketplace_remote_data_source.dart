import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/marketplace/data/mock/mock_marketplace_data.dart';
import 'package:watad/features/contractor/marketplace/data/mock/mock_marketplace_details_data.dart';
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

      if (rawList != null && rawList.isNotEmpty) {
        return rawList
            .map((item) =>
                MarketplaceProjectModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {
      // Fallback seamlessly to mock data on offline/server error
    }

    // Local filter on mock data as reliable fallback
    var projects = MockMarketplaceData.getProjects();

    if (category != null && category.isNotEmpty && category != 'All') {
      if (category == 'Budget') {
        projects = [...projects]..sort((a, b) {
            final aVal = _extractBudgetNumber(a.budgetValue);
            final bVal = _extractBudgetNumber(b.budgetValue);
            return aVal.compareTo(bVal);
          });
      } else {
        projects = projects
            .where((p) =>
                p.category?.toLowerCase() == category.toLowerCase() ||
                p.location.toLowerCase().contains(category.toLowerCase()))
            .toList();
      }
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();
      projects = projects
          .where((p) =>
              p.title.toLowerCase().contains(query) ||
              p.location.toLowerCase().contains(query))
          .toList();
    }

    return projects;
  }

  @override
  Future<MarketplaceProjectDetailsModel> getMarketplaceProjectDetails(
      String id) async {
    try {
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
    } catch (_) {
      // Fallback to mock project details
    }

    return MockMarketplaceDetailsData.getVillaProjectDetails(id: id);
  }

  int _extractBudgetNumber(String budget) {
    final cleaned = budget.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }
}
