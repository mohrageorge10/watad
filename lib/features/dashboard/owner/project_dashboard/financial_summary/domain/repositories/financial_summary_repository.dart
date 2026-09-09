import '../../domain/entities/financial_summary_data.dart';

abstract class FinancialSummaryRepository {
  Future<FinancialSummaryData> getFinancialSummary(String projectId);
}
