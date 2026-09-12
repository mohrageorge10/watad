import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/daily_logs/domain/entities/daily_log_submission_entity.dart';

abstract class DailyLogsRepository {
  Future<ApiResult<bool>> submitDailyLog(DailyLogSubmissionEntity submission);
}
