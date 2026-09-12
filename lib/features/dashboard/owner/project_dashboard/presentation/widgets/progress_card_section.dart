import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/dashboard_data.dart';

class ProgressCardSection extends StatelessWidget {
  final ConstructionProgress progress;

  const ProgressCardSection({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overall Construction Progress',
            style: AppTextStyles.font16BoldWhite,
          ),
          SizedBox(height: 8.h),
          Text(
            '${progress.overallPercentage}%',
            style: AppTextStyles.font24Bold.copyWith(
              color: AppColors.white100,
              fontSize: 32.sp,
            ),
          ),
          SizedBox(height: 16.h),
          // Progress bar
          Stack(
            children: [
              Container(
                height: 4.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white100.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    height: 4.h,
                    width: constraints.maxWidth * (progress.overallPercentage / 100),
                    decoration: BoxDecoration(
                      color: AppColors.white100,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                title: 'Elapsed Time',
                value: '${progress.elapsedPercentage}%',
              ),
              _buildStatItem(
                title: 'Current Stage',
                value: progress.currentStage,
                subtitle: progress.stageStatus,
              ),
              _buildStatItem(
                title: 'Days to Finish',
                value: '${progress.daysToFinish}',
                subtitle: 'days',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String value,
    String? subtitle,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.font10MediumWhite,
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: AppTextStyles.font16BoldWhite.copyWith(fontSize: 14.sp),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: AppTextStyles.font12MediumGrey.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
