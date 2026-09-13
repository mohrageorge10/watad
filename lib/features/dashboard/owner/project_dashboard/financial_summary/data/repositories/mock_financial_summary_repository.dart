import 'package:watad/core/network/api/api_result.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../domain/entities/financial_summary_data.dart';
import '../../domain/repositories/financial_summary_repository.dart';

class MockFinancialSummaryRepository implements FinancialSummaryRepository {
  @override
  Future<ApiResult<FinancialSummaryData>> getFinancialSummary(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 800));

    return ApiResult.success(FinancialSummaryData(
      totalBudget: '12,500,000 EGP',
      breakdowns: [
        BudgetBreakdownItem(
          title: 'Actual Spent',
          value: '6,250,000',
          percentage: '50%',
          color: AppColors.primary,
        ),
        BudgetBreakdownItem(
          title: 'In Escrow',
          value: '4,000,000',
          percentage: '32%',
          color: AppColors.icon, // Yellow
        ),
        BudgetBreakdownItem(
          title: 'Remaining',
          value: '2,250,000',
          percentage: '18%',
          color: AppColors.deactivation, // Grey
        ),
      ],
      quickStats: [
        QuickStat(
          title: 'Committed',
          value: '3,150,000',
          percentage: '25%',
        ),
        QuickStat(
          title: 'In Escrow',
          value: '4,000,000',
          percentage: '32%',
        ),
        QuickStat(
          title: 'Uncommitted',
          value: '5,350,000',
          percentage: '43%',
        ),
      ],
      latestPayments: [
        PaymentItem(
          title: 'Consultancy Fees',
          subtitle: 'Phase 1 - Design Approval',
          date: '12 Oct 2024',
          value: '150,000 EGP',
          status: 'Completed',
          statusColor: AppColors.accept, // Green
        ),
        PaymentItem(
          title: 'Contractor Payment',
          subtitle: 'Milestone 2 - Foundation',
          date: '05 Oct 2024',
          value: '850,000 EGP',
          status: 'Pending',
          statusColor: AppColors.icon, // Yellow
        ),
        PaymentItem(
          title: 'Material Procurement',
          subtitle: 'Steel & Cement',
          date: '28 Sep 2024',
          value: '1,200,000 EGP',
          status: 'Completed',
          statusColor: AppColors.accept,
        ),
      ],
    ));
  }
}
