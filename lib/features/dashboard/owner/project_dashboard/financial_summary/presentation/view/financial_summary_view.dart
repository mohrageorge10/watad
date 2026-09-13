import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../cubit/financial_summary_cubit.dart';
import '../cubit/financial_summary_state.dart';
import '../widgets/total_budget_card.dart';
import '../widgets/budget_breakdown_card.dart';
import '../widgets/quick_stats_card.dart';
import '../widgets/latest_payments_section.dart';

class FinancialSummaryView extends StatelessWidget {
  const FinancialSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FinancialSummaryCubit>()..fetchSummaryData(),
      child: const FinancialSummaryBody(),
    );
  }
}

class FinancialSummaryBody extends StatelessWidget {
  const FinancialSummaryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 16.w,
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(
                          Icons.arrow_back,
                          color: AppColors.primary,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    Text(
                      'Financial Summary',
                      style: AppTextStyles.font14SemiBoldDark.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<FinancialSummaryCubit, FinancialSummaryState>(
                builder: (context, state) {
                  if (state is FinancialSummaryLoading) {
                    return const ListShimmer();
                  } else if (state is FinancialSummaryError) {
                    return AppEmptyStateWidget(
                      title: 'Something went wrong',
                      message: state.message,
                      icon: const Icon(Icons.error_outline, size: 72, color: Colors.red),
                      buttonTitle: 'Retry',
                      onButtonPressed: () {
                        context.read<FinancialSummaryCubit>().fetchSummaryData();
                      },
                    );
                  } else if (state is FinancialSummaryLoaded) {
                    final data = state.data;
                    return RefreshIndicator(
                      onRefresh: () async {
                        await context.read<FinancialSummaryCubit>().fetchSummaryData();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Overview',
                              style: AppTextStyles.font16SemiBold,
                            ),
                            SizedBox(height: 16.h),
                            
                            TotalBudgetCard(totalBudget: data.totalBudget),
                            SizedBox(height: 16.h),
                            
                            BudgetBreakdownCard(breakdowns: data.breakdowns),
                            SizedBox(height: 16.h),
                            
                            QuickStatsCard(stats: data.quickStats),
                            SizedBox(height: 24.h),
                            
                            LatestPaymentsSection(payments: data.latestPayments),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
