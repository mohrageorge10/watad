import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/core/errors/error_handler.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/core/theme/app_colors.dart';
import '../../domain/entities/financial_summary_data.dart';
import '../../domain/repositories/financial_summary_repository.dart';
import '../datasources/financial_summary_remote_data_source.dart';
import 'package:intl/intl.dart';

class FinancialSummaryRepositoryImpl implements FinancialSummaryRepository {
  final FinancialSummaryRemoteDataSource remoteDataSource;

  FinancialSummaryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ApiResult<FinancialSummaryData>> getFinancialSummary(
      String projectId) async {
    try {
      final response = await remoteDataSource.getFinancialOverview(projectId);
      final data = response.data;

      if (data == null) {
        return ApiResult.failure(const ServerFailure(errMessage: 'No data found'));
      }

      final formatCurrency = NumberFormat("#,##0.00", "en_US");
      
      String formatValue(num? value) {
        if (value == null) return "0.00";
        return formatCurrency.format(value);
      }

      final totalBudgetStr = '${formatValue(data.totalContractAmount)} EGP';
      
      final committedAmount = data.totalPaidAmount + data.totalPendingAmount;
      final committedPercentage = data.totalContractAmount > 0 
          ? ((committedAmount / data.totalContractAmount) * 100).toInt() 
          : 0;

      final summary = FinancialSummaryData(
        totalBudget: totalBudgetStr,
        breakdowns: [
          BudgetBreakdownItem(
            title: 'Actual Spent',
            value: formatValue(data.totalPaidAmount),
            percentage: '${data.paidPercentage}%',
            color: AppColors.primary,
          ),
          BudgetBreakdownItem(
            title: 'In Escrow',
            value: formatValue(data.totalPendingAmount),
            percentage: '${data.pendingPercentage}%',
            color: AppColors.icon,
          ),
          BudgetBreakdownItem(
            title: 'Remaining',
            value: formatValue(data.remainingAmount),
            percentage: '${data.remainingPercentage}%',
            color: AppColors.deactivation,
          ),
        ],
        quickStats: [
          QuickStat(
            title: 'Committed',
            value: formatValue(committedAmount),
            percentage: '$committedPercentage%',
          ),
          QuickStat(
            title: 'In Escrow',
            value: formatValue(data.totalPendingAmount),
            percentage: '${data.pendingPercentage}%',
          ),
          QuickStat(
            title: 'Uncommitted',
            value: formatValue(data.remainingAmount),
            percentage: '${data.remainingPercentage}%',
          ),
        ],
        latestPayments: data.paymentMilestones.map((payment) {
              return PaymentItem(
                title: payment.title,
                subtitle: '',
                date: payment.targetCompletionDate,
                value: '${formatValue(payment.amount)} EGP',
                status: payment.paymentStatus,
                statusColor: payment.paymentStatus.toLowerCase() == 'completed' || payment.paymentStatus.toLowerCase() == 'paid'
                    ? AppColors.accept
                    : AppColors.icon,
              );
            }).toList(),
      );

      return ApiResult.success(summary);
    } catch (e) {
      return ApiResult.failure(ErrorHandler.handle(e));
    }
  }
}
