import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/home/data/models/contractor_project_model.dart';

abstract class ContractorProjectsRemoteDataSource {
  Future<List<ContractorProjectModel>> fetchContractorProjects({int? status});
}

class ContractorProjectsRemoteDataSourceImpl
    implements ContractorProjectsRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  ContractorProjectsRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.secureStorage,
    required this.cacheHelper,
  });

  @override
  Future<List<ContractorProjectModel>> fetchContractorProjects({
    int? status,
  }) async {
    // 1. Retrieve token securely without hardcoding
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    // 2. Prepare headers with Bearer Token
    final headers = <String, dynamic>{
      if (token != null && token.isNotEmpty)
        ApiKey.authorization: ApiKey.bearer(token),
    };

    // 3. Query Parameter Logic: include status only if provided
    final queryParameters = <String, dynamic>{
      ApiQueryParams.status: ?status,
    };

    // 4. API Request
    final response = await apiConsumer.get(
      EndPoints.contractorProjects,
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      headers: headers,
    );

    // 5. Safe and flexible parsing
    if (response is List) {
      return response
          .map((item) =>
              ContractorProjectModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic>) {
      final dynamic data =
          response[ApiKey.data] ?? response['items'] ?? response['projects'];
      if (data is List) {
        return data
            .map((item) =>
                ContractorProjectModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    }

    return const [];
  }
}
