import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../../data/repositories/mock_financial_summary_repository.dart';
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
      create: (context) => FinancialSummaryCubit(MockFinancialSummaryRepository())
        ..fetchSummaryData('mock_project_id'),
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
      body: SafeArea(
        child: BlocBuilder<FinancialSummaryCubit, FinancialSummaryState>(
          builder: (context, state) {
            if (state is FinancialSummaryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FinancialSummaryError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is FinancialSummaryLoaded) {
              final data = state.data;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Custom App Bar
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.white100,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
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
                            'Villa – New Cairo', // Mocked project name
                            style: AppTextStyles.font14SemiBoldDark.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    
                    Text(
                      'Financial Summary',
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
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
