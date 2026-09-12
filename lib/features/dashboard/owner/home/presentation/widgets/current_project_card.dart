import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/current_project_overview.dart';
import 'package:watad/features/dashboard/owner/home/presentation/widgets/project_status_badge.dart';


class CurrentProjectCard extends StatelessWidget {
  const CurrentProjectCard({
    super.key,
    required this.overview,
    required this.onGoToDashboard,
  });

  final CurrentProjectOverview overview;
  final VoidCallback onGoToDashboard;

  @override
  Widget build(BuildContext context) {
    final progress = overview.overallProgressPercentage.clamp(0, 100);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overview.title,
                      style: AppTextStyles.font16SemiBold.copyWith(
                        color: AppColors.white100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ProjectStatusBadge(status: overview.status),
                    SizedBox(height: 12.h),
                    Text(
                      overview.location,
                      style: AppTextStyles.font12MediumGrey.copyWith(
                        color: AppColors.white100.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Overall Progress',
                      style: AppTextStyles.font12MediumGrey.copyWith(
                        color: AppColors.white100.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: overview.imageUrl != null
                    ? Image.network(
                        overview.imageUrl!,
                        width: 72.w,
                        height: 72.w,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => _placeholderImage(),
                      )
                    : _placeholderImage(),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${progress.toStringAsFixed(0)}%',
                style: AppTextStyles.font22BoldPrimary.copyWith(
                  color: AppColors.white100,
                  fontSize: 28.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    minHeight: 4.h,
                    backgroundColor: AppColors.white100.withValues(alpha: 0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white100),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 62.h,
            child: ElevatedButton(
              onPressed: onGoToDashboard,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white100,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text(
                'Go To Dashboard',
                style: AppTextStyles.font14Medium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      width: 64.w,
      height: 64.w,
      color: AppColors.white100.withValues(alpha: 0.2),
      child: const Icon(Icons.home_work_outlined, color: AppColors.white100),
    );
  }
}
