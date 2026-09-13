import 'package:watad/core/network/api/api_result.dart';
import '../entities/financial_summary_data.dart';
import '../repositories/financial_summary_repository.dart';

class GetFinancialSummaryUseCase {
  final FinancialSummaryRepository repository;

  GetFinancialSummaryUseCase(this.repository);

  Future<ApiResult<FinancialSummaryData>> call(String projectId) {
    return repository.getFinancialSummary(projectId);
  }
}
