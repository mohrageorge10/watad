import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/project_summary.dart';
import 'package:watad/features/dashboard/owner/home/presentation/widgets/project_status_badge.dart';


class ProjectListItem extends StatelessWidget {
  const ProjectListItem({super.key, required this.project, required this.onTap});

  final ProjectSummary project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: project.imageUrl != null
                    ? Image.network(
                        project.imageUrl!,
                        width: 56.w,
                        height: 56.w,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholder(),
                      )
                    : _placeholder(),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.title, style: AppTextStyles.font14SemiBoldDark),
                    SizedBox(height: 2.h),
                    Text(project.location, style: AppTextStyles.font12Regular.copyWith(fontSize: 10.sp, color: AppColors.grey500)),
                    SizedBox(height: 4.h),
                    Text(
                      'Updated ${project.updatedAt != null ? _formatTimeAgo(project.updatedAt!) : 'recently'}',
                      style: AppTextStyles.font12Regular.copyWith(fontSize: 10.sp, color: AppColors.grey400),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProjectStatusBadge(status: project.status),
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${project.overallProgressPercentage.toStringAsFixed(0)}%',
                        style: AppTextStyles.font14Medium.copyWith(
                          fontSize: 12.sp,
                          color: AppColors.grey900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      SizedBox(
                        width: 40.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: LinearProgressIndicator(
                            value: project.overallProgressPercentage.clamp(0, 100) / 100,
                            minHeight: 4.h,
                            backgroundColor: AppColors.grey300,
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(Icons.arrow_forward, color: AppColors.primary, size: 16.sp),
                    ],
                  ),
                ],
              ),
            ],
          ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 52.w,
      height: 52.w,
      color: AppColors.grey100,
      child: Icon(Icons.home_outlined, color: AppColors.grey400),
    );
  }

  String _formatTimeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inDays > 0) return '${diff.inDays} days ago';
    if (diff.inHours > 0) return '${diff.inHours} hours ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes} minutes ago';
    return 'just now';
  }
}
