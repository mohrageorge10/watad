import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/daily_logs/domain/entities/daily_log_submission_entity.dart';
import 'package:watad/features/contractor/daily_logs/domain/repositories/daily_logs_repository.dart';

class SubmitDailyLogUseCase {
  final DailyLogsRepository repository;

  SubmitDailyLogUseCase(this.repository);

  Future<ApiResult<bool>> call(DailyLogSubmissionEntity submission) async {
    return await repository.submitDailyLog(submission);
  }
}
