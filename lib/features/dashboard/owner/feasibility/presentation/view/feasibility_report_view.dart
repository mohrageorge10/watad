import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'package:watad/features/dashboard/owner/feasibility/presentation/cubit/feasibility_cubit.dart';
import 'package:intl/intl.dart';

class FeasibilityReportView extends StatelessWidget {
  final FeasibilityReport report;

  const FeasibilityReportView({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FeasibilityCubit>(),
      child: _FeasibilityReportContent(report: report),
    );
  }
}

class _FeasibilityReportContent extends StatelessWidget {
  final FeasibilityReport report;

  const _FeasibilityReportContent({required this.report});

  String _mapFinishingLevel(int level) {
    switch (level) {
      case 0: return 'Basic';
      case 1: return 'Standard';
      case 2: return 'High';
      default: return 'Unknown';
    }
  }

  String _formatCurrency(double amount) {
    final format = NumberFormat("#,##0", "en_US");
    return format.format(amount);
  }

  void _saveReport(BuildContext context) {
    context.read<FeasibilityCubit>().saveReport(
      report.id, 
      "My New Project",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: SafeArea(
        child: BlocConsumer<FeasibilityCubit, FeasibilityState>(
          listener: (context, state) {
            if (state is SaveReportSuccess) {
              AppToast.showSuccess(context, 'Report saved successfully!');
              context.pop();
            } else if (state is SaveReportError) {
              AppToast.showError(context, state.failure.errMessage);
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context),
                        SizedBox(height: 32.h),
                        
                        Text(
                          'Estimated Total Cost',
                          style: AppTextStyles.font18SemiBoldDark.copyWith(
                            color: AppColors.grey900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${_formatCurrency(report.estimatedTotalCost)} EGP',
                          style: AppTextStyles.font24Bold.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // Chart Card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: AppColors.white100,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.grey300.withValues(alpha: 0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120.w,
                                height: 120.h,
                                child: PieChart(
                                  PieChartData(
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40.r,
                                    sections: _getChartSections(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 24.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLegendItem(AppColors.primary, 'Material Cost', report.materialsCost),
                                    SizedBox(height: 12.h),
                                    _buildLegendItem(const Color(0xFFFFC107), 'Labor Cost', report.laborCost),
                                    SizedBox(height: 12.h),
                                    _buildLegendItem(AppColors.grey400, 'Finishing Cost', report.finishesCost),
                                    SizedBox(height: 12.h),
                                    _buildLegendItem(AppColors.grey200, 'Contingency', report.contingenciesCost),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(height: 24.h),
                        Divider(color: AppColors.primary, thickness: 1),
                        SizedBox(height: 24.h),

                        // Details Card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            color: AppColors.white100,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.grey300.withValues(alpha: 0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Bulit Area',
                                style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${_formatCurrency(report.totalBuiltArea)} m²',
                                style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 24.h),
                              Text(
                                'Finishing Level',
                                style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                _mapFinishingLevel(report.finishingLevel),
                                style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Save Button
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: AppElevatedButton(
                      title: 'Save Project',
                      onPressed: state is SaveReportLoading
                          ? null
                          : () => _saveReport(context),
                      isLoading: state is SaveReportLoading,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () => context.pop(),
              child: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
            ),
          ),
          Text(
            'Feasibility Report',
            style: AppTextStyles.font16SemiBold.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String title, double cost) {
    final percentage = report.estimatedTotalCost > 0 
        ? ((cost / report.estimatedTotalCost) * 100).round() 
        : 0;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 4.h),
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.font12Regular.copyWith(color: AppColors.grey900, fontWeight: FontWeight.w500),
              ),
              Text(
                '${_formatCurrency(cost)} ($percentage%)',
                style: AppTextStyles.font12Regular.copyWith(color: AppColors.grey500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _getChartSections() {
    final total = report.estimatedTotalCost > 0 ? report.estimatedTotalCost : 1.0;
    
    return [
      PieChartSectionData(
        color: AppColors.primary,
        value: report.materialsCost / total,
        title: '',
        radius: 20.r,
      ),
      PieChartSectionData(
        color: const Color(0xFFFFC107),
        value: report.laborCost / total,
        title: '',
        radius: 20.r,
      ),
      PieChartSectionData(
        color: AppColors.grey400,
        value: report.finishesCost / total,
        title: '',
        radius: 20.r,
      ),
      PieChartSectionData(
        color: AppColors.grey200,
        value: report.contingenciesCost / total,
        title: '',
        radius: 20.r,
      ),
    ];
  }
}
