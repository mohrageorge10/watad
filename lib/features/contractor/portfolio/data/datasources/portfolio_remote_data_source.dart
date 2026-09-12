import 'package:dio/dio.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/portfolio/data/mock/portfolio_projects_mock_data.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';

abstract class PortfolioRemoteDataSource {
  Future<List<PortfolioItemModel>> fetchContractorPortfolio();

  Future<List<PortfolioProjectItemModel>> getPortfolioProjects({
    required String contractorId,
  });

  Future<PortfolioProjectItemModel> addPortfolioProject({
    required Map<String, dynamic> projectData,
  });

  Future<PortfolioProjectItemModel> updatePortfolioProject({
    required String projectId,
    required Map<String, dynamic> projectData,
  });

  Future<PortfolioProjectItemModel> getPortfolioProjectDetails({
    required String projectId,
  });

  Future<bool> deletePortfolioProject({
    required String projectId,
  });
}

class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  PortfolioRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.secureStorage,
    required this.cacheHelper,
  });

  Future<Map<String, dynamic>> _getHeaders() async {
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);
    return <String, dynamic>{
      if (token != null && token.isNotEmpty)
        ApiKey.authorization: ApiKey.bearer(token),
    };
  }

  @override
  Future<List<PortfolioItemModel>> fetchContractorPortfolio() async {
    try {
      final headers = await _getHeaders();
      final response = await apiConsumer.get(
        EndPoints.contractorPortfolio,
        headers: headers,
      );

      if (response is List) {
        return response
            .map((item) =>
                PortfolioItemModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else if (response is Map<String, dynamic>) {
        final dynamic data =
            response[ApiKey.data] ?? response['items'] ?? response['portfolio'];
        if (data is List) {
          return data
              .map((item) =>
                  PortfolioItemModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      }

      return const [];
    } on DioException {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PortfolioProjectItemModel>> getPortfolioProjects({
    required String contractorId,
  }) async {
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    if (token != null && token.isNotEmpty) {
      try {
        final result = await fetchContractorPortfolio();
        if (result.isNotEmpty) return result;
      } catch (_) {}
    }

    // Fallback for unauthenticated local development / testing
    await Future.delayed(const Duration(milliseconds: 400));
    return PortfolioProjectsMockData.projects;
  }

  @override
  Future<PortfolioProjectItemModel> addPortfolioProject({
    required Map<String, dynamic> projectData,
  }) async {
    final headers = await _getHeaders();
    final token = headers[ApiKey.authorization];

    if (token != null) {
      try {
        final response = await apiConsumer.post(
          EndPoints.contractorPortfolio,
          data: projectData,
          headers: headers,
        );

        if (response is Map<String, dynamic>) {
          final data = response[ApiKey.data] ?? response;
          if (data is Map<String, dynamic>) {
            return PortfolioProjectItemModel.fromJson(data);
          }
        }
      } catch (_) {
        rethrow;
      }
    }

    // Local / Mock fallback
    await Future.delayed(const Duration(milliseconds: 500));
    return PortfolioProjectItemModel.fromJson({
      'id': 'proj_${DateTime.now().millisecondsSinceEpoch}',
      ...projectData,
      'badgeText': 'Completed',
      'badgeType': 'success',
    });
  }

  @override
  Future<PortfolioProjectItemModel> updatePortfolioProject({
    required String projectId,
    required Map<String, dynamic> projectData,
  }) async {
    final headers = await _getHeaders();
    final token = headers[ApiKey.authorization];

    if (token != null) {
      try {
        final response = await apiConsumer.put(
          EndPoints.contractorPortfolio,
          data: projectData,
          headers: headers,
        );

        if (response is Map<String, dynamic>) {
          final data = response[ApiKey.data] ?? response;
          if (data is Map<String, dynamic>) {
            return PortfolioProjectItemModel.fromJson(data);
          }
        }
      } catch (_) {
        rethrow;
      }
    }

    await Future.delayed(const Duration(milliseconds: 400));
    return PortfolioProjectItemModel.fromJson({
      'id': projectId,
      ...projectData,
    });
  }

  @override
  Future<PortfolioProjectItemModel> getPortfolioProjectDetails({
    required String projectId,
  }) async {
    final headers = await _getHeaders();
    final token = headers[ApiKey.authorization];

    if (token != null) {
      try {
        final response = await apiConsumer.get(
          EndPoints.portfolioProject(projectId),
          headers: headers,
        );

        if (response is Map<String, dynamic>) {
          final data = response[ApiKey.data] ?? response;
          if (data is Map<String, dynamic>) {
            return PortfolioProjectItemModel.fromJson(data);
          }
        }
      } catch (_) {
        rethrow;
      }
    }

    await Future.delayed(const Duration(milliseconds: 300));
    final match = PortfolioProjectsMockData.projects.firstWhere(
      (p) => p.id == projectId,
      orElse: () => PortfolioProjectsMockData.projects.first,
    );
    return match;
  }

  @override
  Future<bool> deletePortfolioProject({
    required String projectId,
  }) async {
    final headers = await _getHeaders();
    final token = headers[ApiKey.authorization];

    if (token != null) {
      try {
        await apiConsumer.delete(
          EndPoints.portfolioProject(projectId),
          headers: headers,
        );
        return true;
      } catch (_) {
        rethrow;
      }
    }

    await Future.delayed(const Duration(milliseconds: 400));
    return true;
  }
}
