import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/project_dashboard/data/models/contractor_project_dashboard_model.dart';

abstract class ContractorProjectDashboardRemoteDataSource {
  Future<ContractorProjectDashboardModel> getProjectDashboard(String projectId);
}

class ContractorProjectDashboardRemoteDataSourceImpl
    implements ContractorProjectDashboardRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  ContractorProjectDashboardRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.secureStorage,
    required this.cacheHelper,
  });

  @override
  Future<ContractorProjectDashboardModel> getProjectDashboard(
    String projectId,
  ) async {
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    final headers = <String, dynamic>{
      if (token != null && token.isNotEmpty)
        ApiKey.authorization: ApiKey.bearer(token),
    };

    final response = await apiConsumer.get(
      EndPoints.contractorProjectDashboard(projectId),
      headers: headers.isNotEmpty ? headers : null,
    );

    if (response is Map<String, dynamic>) {
      final dynamic data = response[ApiKey.data] ?? response;
      if (data is Map<String, dynamic>) {
        return ContractorProjectDashboardModel.fromJson(data);
      }
    }

    throw Exception('Failed to load project dashboard data from server.');
  }
}
