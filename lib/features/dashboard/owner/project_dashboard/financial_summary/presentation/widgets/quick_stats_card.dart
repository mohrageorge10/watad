import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/financial_summary_data.dart';

class QuickStatsCard extends StatelessWidget {
  final List<QuickStat> stats;

  const QuickStatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: stats.map((stat) => _buildStatColumn(stat)).toList(),
      ),
    );
  }

  Widget _buildStatColumn(QuickStat stat) {
    return Column(
      children: [
        Text(
          stat.title,
          style: AppTextStyles.font10MediumDark.copyWith(
            color: AppColors.deactivation,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          stat.value,
          style: AppTextStyles.font14SemiBoldDark,
        ),
        SizedBox(height: 2.h),
        Text(
          stat.currency,
          style: AppTextStyles.font10MediumDark.copyWith(
            color: AppColors.deactivation,
          ),
        ),
      ],
    );
  }
}
