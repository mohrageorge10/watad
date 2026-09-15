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
    // 1. Retrieve token securely
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    final headers = <String, dynamic>{
      if (token != null && token.isNotEmpty)
        ApiKey.authorization: ApiKey.bearer(token),
    };

    final queryParameters = <String, dynamic>{
      if (status != null) ApiQueryParams.status: status,
    };

    final response = await apiConsumer.get(
      EndPoints.contractorProjects,
      queryParameters: queryParameters.isNotEmpty ? queryParameters : null,
      headers: headers.isNotEmpty ? headers : null,
    );

    print('fetchContractorProjects response: $response');
    if (response is List) {
      return response
          .map((item) =>
              ContractorProjectModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic>) {
      final dynamic data =
          response[ApiKey.data] ?? response['items'] ?? response['projects'];
      print('fetchContractorProjects extracted data: $data');
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
