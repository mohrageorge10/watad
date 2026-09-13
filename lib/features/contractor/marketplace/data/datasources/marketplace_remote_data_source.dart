import 'package:dio/dio.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/marketplace/data/mock/mock_marketplace_data.dart';
import 'package:watad/features/contractor/marketplace/data/models/marketplace_project_details_model.dart';
import 'package:watad/features/contractor/marketplace/data/models/marketplace_project_model.dart';
import 'package:watad/features/contractor/profile/data/constants/profile_constants.dart';

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
    final effectiveGov = governorate ??
        (category != null && category != 'All' && category != 'Budget'
            ? category
            : null);

    String? targetGov;
    String? targetCity;

    if (effectiveGov != null && effectiveGov.isNotEmpty) {
      final trimmed = effectiveGov.trim();
      if (trimmed.contains(',')) {
        final parts = trimmed.split(',');
        targetCity = parts[0].trim();
        targetGov = parts.length > 1 ? parts[1].trim() : null;
      } else {
        final isGov = ProfileConstants.egyptianGovernorates.any(
          (g) => g.toLowerCase() == trimmed.toLowerCase(),
        );
        if (isGov) {
          targetGov = trimmed;
        } else {
          targetCity = trimmed;
          for (final loc in ProfileConstants.egyptianCityLocations) {
            final locParts = loc.split(',');
            if (locParts[0].trim().toLowerCase() == trimmed.toLowerCase()) {
              targetGov = locParts.length > 1 ? locParts[1].trim() : null;
              break;
            }
          }
        }
      }
    }

    try {
      final headers = await _getAuthHeaders();
      final queryParams = <String, dynamic>{};

      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        queryParams[ApiQueryParams.search] = searchQuery.trim();
      }

      if (targetGov != null && targetGov.isNotEmpty) {
        queryParams[ApiQueryParams.governorate] = targetGov;
      }
      if (targetCity != null && targetCity.isNotEmpty) {
        queryParams[ApiQueryParams.city] = targetCity;
      }

      if (minBudget != null && minBudget > 0) {
        queryParams[ApiQueryParams.minBudget] = minBudget;
      }
      if (maxBudget != null) {
        queryParams[ApiQueryParams.maxBudget] = maxBudget;
      }

      // contractorRecommendedProjects supports Search, Governorate, City, MinBudget, MaxBudget
      final response = await apiConsumer.get(
        EndPoints.contractorRecommendedProjects,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
        headers: headers.isNotEmpty ? headers : null,
      );

      List<dynamic>? rawList;
      if (response is List) {
        rawList = response;
      } else if (response is Map<String, dynamic>) {
        final dynamic data =
            response[ApiKey.data] ?? response['projects'] ?? response['items'];
        if (data is List) {
          rawList = data;
        } else if (data is Map<String, dynamic>) {
          final dynamic items =
              data['items'] ?? data['projects'] ?? data['data'];
          if (items is List) {
            rawList = items;
          }
        }
      }

      List<MarketplaceProjectModel> parsed = [];
      if (rawList != null && rawList.isNotEmpty) {
        parsed = rawList
            .map((item) =>
                MarketplaceProjectModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      // Apply Location Filter
      if (effectiveGov != null && effectiveGov.isNotEmpty) {
        final query = effectiveGov.toLowerCase().trim();
        final cityQuery = targetCity?.toLowerCase().trim();
        final govQuery = targetGov?.toLowerCase().trim();

        final filtered = parsed.where((p) {
          final loc = p.location.toLowerCase();
          final cat = (p.category ?? '').toLowerCase();
          final title = p.title.toLowerCase();

          final matchEffective = loc.contains(query) ||
              cat.contains(query) ||
              title.contains(query);
          final matchCity = cityQuery != null &&
              (loc.contains(cityQuery) || cat.contains(cityQuery));
          final matchGov = govQuery != null &&
              (loc.contains(govQuery) || cat.contains(govQuery));

          return matchEffective || matchCity || matchGov;
        }).toList();

        if (filtered.isNotEmpty) {
          parsed = filtered;
        } else {
          // If real API had 0 projects in this location, use Mock fallback for this location
          final mockProjects = MockMarketplaceData.getProjects();
          final mockFiltered = mockProjects.where((p) {
            final loc = p.location.toLowerCase();
            final cat = (p.category ?? '').toLowerCase();
            final title = p.title.toLowerCase();

            final matchEffective = loc.contains(query) ||
                cat.contains(query) ||
                title.contains(query);
            final matchCity = cityQuery != null &&
                (loc.contains(cityQuery) || cat.contains(cityQuery));
            final matchGov = govQuery != null &&
                (loc.contains(govQuery) || cat.contains(govQuery));

            return matchEffective || matchCity || matchGov;
          }).toList();

          parsed = mockFiltered;
        }
      } else if (parsed.isEmpty) {
        // If All was selected and API returned empty, fallback to all mock projects
        parsed = MockMarketplaceData.getProjects();
      }

      if (searchQuery != null && searchQuery.trim().isNotEmpty) {
        final q = searchQuery.trim().toLowerCase();
        parsed = parsed
            .where((p) =>
                p.title.toLowerCase().contains(q) ||
                p.location.toLowerCase().contains(q) ||
                (p.category ?? '').toLowerCase().contains(q))
            .toList();
      }

      if (minBudget != null && minBudget > 0) {
        parsed = parsed.where((p) => p.numericBudget >= minBudget).toList();
      }

      return parsed;
    } on DioException {
      return _getFilteredMock(
        effectiveGov: effectiveGov,
        targetCity: targetCity,
        targetGov: targetGov,
        searchQuery: searchQuery,
        minBudget: minBudget,
      );
    } catch (_) {
      return _getFilteredMock(
        effectiveGov: effectiveGov,
        targetCity: targetCity,
        targetGov: targetGov,
        searchQuery: searchQuery,
        minBudget: minBudget,
      );
    }
  }

  List<MarketplaceProjectModel> _getFilteredMock({
    String? effectiveGov,
    String? targetCity,
    String? targetGov,
    String? searchQuery,
    int? minBudget,
  }) {
    var list = MockMarketplaceData.getProjects();

    if (effectiveGov != null && effectiveGov.isNotEmpty) {
      final query = effectiveGov.toLowerCase().trim();
      final cityQuery = targetCity?.toLowerCase().trim();
      final govQuery = targetGov?.toLowerCase().trim();

      list = list.where((p) {
        final loc = p.location.toLowerCase();
        final cat = (p.category ?? '').toLowerCase();
        final title = p.title.toLowerCase();

        final matchEffective = loc.contains(query) ||
            cat.contains(query) ||
            title.contains(query);
        final matchCity = cityQuery != null &&
            (loc.contains(cityQuery) || cat.contains(cityQuery));
        final matchGov = govQuery != null &&
            (loc.contains(govQuery) || cat.contains(govQuery));

        return matchEffective || matchCity || matchGov;
      }).toList();
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final q = searchQuery.trim().toLowerCase();
      list = list
          .where((p) =>
              p.title.toLowerCase().contains(q) ||
              p.location.toLowerCase().contains(q) ||
              (p.category ?? '').toLowerCase().contains(q))
          .toList();
    }

    if (minBudget != null && minBudget > 0) {
      list = list.where((p) => p.numericBudget >= minBudget).toList();
    }

    return list;
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
