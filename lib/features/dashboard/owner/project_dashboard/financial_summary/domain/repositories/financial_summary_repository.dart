import 'package:watad/core/network/api/api_result.dart';
import '../../domain/entities/financial_summary_data.dart';

abstract class FinancialSummaryRepository {
  Future<ApiResult<FinancialSummaryData>> getFinancialSummary(String projectId);
}
