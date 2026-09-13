import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class ChangeOrderStatCard extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String value;
  final Color valueColor;
  final String title;
  final String subtitle;

  const ChangeOrderStatCard({
    super.key,
    required this.iconPath,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.value,
    required this.valueColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 12.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black100.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 16.w,
            height: 16.w,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          SizedBox(height: 10.h),
          Text(
            value,
            style: AppTextStyles.font14SemiBoldDark.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w700,
              fontSize: 13.sp,
              height: 1.15,
            ),
          ),
          SizedBox(height: 4.h),
            Text(
              title,
              style: AppTextStyles.font12MediumGrey.copyWith(
                color: AppColors.smallText,
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
                height: 1.2,
              ),
            ),
          SizedBox(height: 2.h),
            Text(
              subtitle,
              style: AppTextStyles.font10MediumDark.copyWith(
                color: AppColors.deactivation,
                fontSize: 9.sp,
                height: 1.25,
              ),
            ),
        ],
      ),
    );
  }
}
