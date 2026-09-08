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

  @override
  Future<List<PortfolioItemModel>> fetchContractorPortfolio() async {
    try {
      // 1. Retrieve authentication token securely from local storage
      final token = await secureStorage.read(key: CacheKeys.token) ??
          (cacheHelper.getData(key: CacheKeys.token) as String?);

      // 2. Inject Bearer Token into headers
      final headers = <String, dynamic>{
        if (token != null && token.isNotEmpty)
          ApiKey.authorization: ApiKey.bearer(token),
      };

      // 3. Centralized endpoint call (GET /api/Contractor/portfolio)
      final response = await apiConsumer.get(
        EndPoints.contractorPortfolio,
        headers: headers,
      );

      // 4. Map JSON response into List<PortfolioItemModel>
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
      // Gracefully catch DioException (401 Unauthorized, timeout, network errors)
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
      return await fetchContractorPortfolio();
    }

    // Fallback for unauthenticated local development / testing
    await Future.delayed(const Duration(milliseconds: 600));
    return PortfolioProjectsMockData.projects;
  }
}
