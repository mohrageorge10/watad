import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/milestone_logs/data/models/milestone_log_item_model.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';

abstract class MilestoneLogsRemoteDataSource {
  Future<MilestoneLogsHeaderModel> getMilestoneHeader(String projectId);

  Future<List<MilestoneLogItemModel>> getMilestoneLogs({
    required String projectId,
    MilestoneLogType? filterType,
  });

  Future<bool> requestMilestoneInspection({
    required String projectId,
    required String milestoneId,
  });
}

class MilestoneLogsRemoteDataSourceImpl
    implements MilestoneLogsRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  MilestoneLogsRemoteDataSourceImpl({
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
  Future<MilestoneLogsHeaderModel> getMilestoneHeader(String projectId) async {
    final headers = await _getAuthHeaders();
    final response = await apiConsumer.get(
      'milestones/project/$projectId/header',
      headers: headers.isNotEmpty ? headers : null,
    );

    if (response is Map<String, dynamic>) {
      final dynamic data = response[ApiKey.data] ?? response;
      if (data is Map<String, dynamic>) {
        return MilestoneLogsHeaderModel.fromJson(data);
      }
    }

    throw const FormatException('Milestone header data not found');
  }

  @override
  Future<List<MilestoneLogItemModel>> getMilestoneLogs({
    required String projectId,
    MilestoneLogType? filterType,
  }) async {
    final headers = await _getAuthHeaders();
    final queryParams = <String, dynamic>{
      if (filterType != null) 'type': filterType.name,
    };

    final response = await apiConsumer.get(
      'milestones/project/$projectId/logs',
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
      headers: headers.isNotEmpty ? headers : null,
    );

    if (response is List) {
      return response
          .map((e) => MilestoneLogItemModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic>) {
      final dynamic data = response[ApiKey.data] ?? response['logs'];
      if (data is List) {
        return data
            .map((e) =>
                MilestoneLogItemModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }

    return const [];
  }

  @override
  Future<bool> requestMilestoneInspection({
    required String projectId,
    required String milestoneId,
  }) async {
    final headers = await _getAuthHeaders();
    final response = await apiConsumer.post(
      'milestones/$milestoneId/request-inspection',
      headers: headers.isNotEmpty ? headers : null,
    );

    if (response is Map<String, dynamic>) {
      return response[ApiKey.isSuccess] == true ||
          response['statusCode'] == 200 ||
          response['statusCode'] == 201 ||
          response['status'] == 'success';
    }
    return response != null;
  }
}
