import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/current_project_overview.dart';
import '../widgets/custom_status_badge.dart';
import '../widgets/project_progress_bar.dart';

class ActiveProjectCardSection extends StatelessWidget {
  final CurrentProjectOverview project;

  const ActiveProjectCardSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: AppTextStyles.font16BoldWhite,
            ),
            SizedBox(height: 12.h),
            CustomStatusBadge(status: project.status),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.white100, size: 14.sp),
                SizedBox(width: 4.w),
                Text(
                  project.location,
                  style: AppTextStyles.font12RegularGrey.copyWith(color: AppColors.white100.withOpacity(0.8)),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Text(
              "Overall Progress",
              style: AppTextStyles.font12MediumGrey.copyWith(color: AppColors.white100.withOpacity(0.8)),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Text(
                  "${project.overallProgressPercentage.toInt()}%",
                  style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.white100),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ProjectProgressBar(
                    progressPercent: project.overallProgressPercentage.toInt(),
                    isDarkBackground: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
