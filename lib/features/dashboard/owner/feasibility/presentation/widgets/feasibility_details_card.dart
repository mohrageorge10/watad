import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'package:intl/intl.dart';

class FeasibilityDetailsCard extends StatelessWidget {
  final FeasibilityReport report;

  const FeasibilityDetailsCard({super.key, required this.report});

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

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
