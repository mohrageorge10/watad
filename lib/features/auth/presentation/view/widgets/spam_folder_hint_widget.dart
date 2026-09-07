import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class SpamFolderHintWidget extends StatelessWidget {
  const SpamFolderHintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.primary,
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: const Color(0xFF1D1D1F),
                  fontSize: 12.sp,
                  fontFamily: 'Inter',
                  height: 1.4,
                ),
                children: const [
                  TextSpan(
                    text: "Can't find the email? Please check your ",
                  ),
                  TextSpan(
                    text: "Spam",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: " or ",
                  ),
                  TextSpan(
                    text: "Junk",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  TextSpan(
                    text: " folder.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
