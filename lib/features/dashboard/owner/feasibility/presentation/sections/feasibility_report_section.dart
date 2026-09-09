import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'package:watad/features/dashboard/owner/feasibility/presentation/cubit/feasibility_cubit.dart';
import 'package:intl/intl.dart';
import '../widgets/feasibility_header_widget.dart';
import '../widgets/feasibility_pie_chart_card.dart';
import '../widgets/feasibility_details_card.dart';

class FeasibilityReportSection extends StatelessWidget {
  final FeasibilityReport report;

  const FeasibilityReportSection({super.key, required this.report});

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
    return BlocConsumer<FeasibilityCubit, FeasibilityState>(
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
                    const FeasibilityHeaderWidget(title: 'Feasibility Report'),
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

                    FeasibilityPieChartCard(report: report),
                    
                    SizedBox(height: 24.h),
                    Divider(color: AppColors.primary, thickness: 1),
                    SizedBox(height: 24.h),

                    FeasibilityDetailsCard(report: report),
                  ],
                ),
              ),
            ),
            
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
    );
  }
}
