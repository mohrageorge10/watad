import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class MediaUploadDropzoneWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const MediaUploadDropzoneWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFE5E5EA),
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Blue Camera Outline Icon
            Icon(
              Icons.camera_alt_outlined,
              color: const Color(0xFF1E3A8A),
              size: 36.r,
            ),
            SizedBox(height: 12.h),

            // Main text
            Text(
              'Drag & drop or capture photo/video',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1D1D1F),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6.h),

            // Subtitle text
            Text(
              'Photos will be analyzed by AI to verify progress against milestones.',
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF8E8E93),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
