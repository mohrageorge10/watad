import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/grey_image_placeholder.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/project_status_badge.dart';

class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({
    super.key,
    required this.title,
    required this.location,
    required this.timeOrAmount,
    required this.badgeText,
    required this.badgeColorHex,
    this.progress,
    this.imagePath,
    this.onTap,
  });

  final String title;
  final String location;
  final String timeOrAmount;
  final String badgeText;
  final String badgeColorHex;
  final String? progress;
  final String? imagePath;
  final VoidCallback? onTap;

  double? _parseProgress(String? progressStr) {
    if (progressStr == null) return null;
    final cleaned = progressStr.replaceAll('%', '').trim();
    final value = double.tryParse(cleaned);
    if (value == null) return null;
    return (value / 100).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final progressValue = _parseProgress(progress);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Project Image (64x64px, borderRadius: 8px)
                GreyImagePlaceholder(
                  width: 64.w,
                  height: 64.h,
                  borderRadius: 8,
                  iconSize: 24,
                ),

                // 2. Project Details (Expanded Column)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: const Color(0xFF1D1D1F),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          location,
                          style: TextStyle(
                            color: const Color(0xFF8E8E93),
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          timeOrAmount,
                          style: TextStyle(
                            color: timeOrAmount.startsWith('EGP')
                                ? AppColors.primary
                                : const Color(0xFF8E8E93),
                            fontSize: 12.sp,
                            fontWeight: timeOrAmount.startsWith('EGP')
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),

                // 3. Project Status & Progress (Right Column)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Badge
                    ProjectStatusBadge(
                      text: badgeText,
                      colorHex: badgeColorHex,
                    ),

                    // Arrow Icon
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.primary,
                        size: 16.r,
                      ),
                    ),

                    // Progress Row (if progress exists)
                    if (progress != null && progressValue != null)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            progress!,
                            style: TextStyle(
                              color: const Color(0xFF1D1D1F),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          SizedBox(
                            width: 36.w,
                            height: 4.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2.r),
                              child: LinearProgressIndicator(
                                value: progressValue,
                                backgroundColor: const Color(0xFFD1D1D6),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
