import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class PhaseProgressBar extends StatelessWidget {
  final String title;
  final int percentage;
  final Color indicatorColor;

  const PhaseProgressBar({
    super.key,
    required this.title,
    required this.percentage,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                fontSize: 13.sp,
              ),
            ),
            Text(
              "$percentage%",
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            value: percentage / 100,
            minHeight: 6.h,
            backgroundColor: AppColors.grey300.withValues(alpha: 0.3),
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        ),
      ],
    );
  }
}
