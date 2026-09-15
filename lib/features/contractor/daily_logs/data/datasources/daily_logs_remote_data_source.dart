import 'package:dio/dio.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/daily_logs/data/models/daily_log_submission_model.dart';

abstract class DailyLogsRemoteDataSource {
  Future<bool> submitDailyLog(DailyLogSubmissionModel submission);
}

class DailyLogsRemoteDataSourceImpl implements DailyLogsRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  DailyLogsRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.secureStorage,
    required this.cacheHelper,
  });

  @override
  Future<bool> submitDailyLog(DailyLogSubmissionModel submission) async {
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    final headers = <String, dynamic>{
      if (token != null && token.isNotEmpty)
        ApiKey.authorization: ApiKey.bearer(token),
    };

    final data = <String, dynamic>{
      'ProjectId': submission.projectId,
      ApiKey.milestoneId: submission.milestoneId,
      ApiKey.workersCount: submission.workersCount,
      ApiKey.equipmentUsed: submission.equipmentUsed,
      ApiKey.workSummary: submission.workSummary,
    };

    if (submission.mediaPaths.isNotEmpty) {
      data[ApiKey.mediaFile] = await Future.wait(
        submission.mediaPaths.map((path) => MultipartFile.fromFile(path)),
      );
    }

    final response = await apiConsumer.post(
      EndPoints.siteLogs,
      data: data,
      isFormData: true,
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
