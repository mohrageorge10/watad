import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class PortfolioStatusBadge extends StatelessWidget {
  final String text;
  final String type; // 'success' or 'pending'

  const PortfolioStatusBadge({
    super.key,
    required this.text,
    this.type = 'success',
  });

  static const Color successGreen = Color(0xFF00B368);

  bool get isSuccess => type.toLowerCase() == 'success';

  @override
  Widget build(BuildContext context) {
    if (isSuccess) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: successGreen,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: AppColors.white100,
              size: 13.r,
            ),
            SizedBox(width: 4.w),
            Text(
              text,
              style: TextStyle(
                color: AppColors.white100,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    // Pending type: transparent background, blue text and blue clock icon
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      color: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.access_time_rounded,
            color: AppColors.primary,
            size: 14.r,
          ),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
