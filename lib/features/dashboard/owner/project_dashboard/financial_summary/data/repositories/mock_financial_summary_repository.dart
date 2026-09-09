import '../../../../../../../core/theme/app_colors.dart';
import '../../domain/entities/financial_summary_data.dart';
import '../../domain/repositories/financial_summary_repository.dart';

class MockFinancialSummaryRepository implements FinancialSummaryRepository {
  @override
  Future<FinancialSummaryData> getFinancialSummary(String projectId) async {
    await Future.delayed(const Duration(milliseconds: 800));

    return FinancialSummaryData(
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
          currency: 'EGP',
        ),
        QuickStat(
          title: 'Spent to Date',
          value: '6,250,000',
          currency: 'EGP',
        ),
        QuickStat(
          title: 'Remaining Budget',
          value: '2,250,000',
          currency: 'EGP',
        ),
      ],
      latestPayments: [
        PaymentItem(
          title: 'Payment #4',
          subtitle: 'Steel & Rebar Supply',
          date: '20 May 2024',
          value: '230,000 EGP',
          status: 'Paid',
          statusColor: AppColors.accept,
        ),
        PaymentItem(
          title: 'Payment #3',
          subtitle: 'Concrete Works',
          date: '05 May 2024',
          value: '320,000 EGP',
          status: 'Paid',
          statusColor: AppColors.accept,
        ),
        PaymentItem(
          title: 'Payment #2',
          subtitle: 'Excavation Works',
          date: '18 Apr 2024',
          value: '210,000 EGP',
          status: 'Paid',
          statusColor: AppColors.accept,
        ),
      ],
    );
  }
}
