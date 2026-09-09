import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import '../../domain/entities/phase_progress_item.dart';
import 'phase_progress_bar.dart';

class OverallProgressCard extends StatelessWidget {
  final int overallProgress;
  final List<PhaseProgressItem> phaseList;

  const OverallProgressCard({
    super.key,
    required this.overallProgress,
    required this.phaseList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "OVERALL PROGRESS",
                style: AppTextStyles.font12MediumGrey.copyWith(
                  color: AppColors.grey900,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                "$overallProgress%",
                style: AppTextStyles.font22BoldPrimary.copyWith(
                  fontSize: 24.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: overallProgress / 100,
              minHeight: 12.h,
              backgroundColor: AppColors.grey300.withValues(alpha: 0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          SizedBox(height: 24.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: phaseList.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final phase = phaseList[index];
              return PhaseProgressBar(
                title: phase.title,
                percentage: phase.percentage,
                indicatorColor: phase.indicatorColor,
              );
            },
          ),
        ],
      ),
    );
  }
}
