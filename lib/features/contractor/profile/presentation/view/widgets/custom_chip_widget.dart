import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class CustomChipWidget extends StatelessWidget {
  final String label;
  final bool hasDot;
  final bool hasCloseIcon;
  final VoidCallback? onCloseTap;
  final Color? dotColor;
  final Color? backgroundColor;

  const CustomChipWidget({
    super.key,
    required this.label,
    this.hasDot = false,
    this.hasCloseIcon = false,
    this.onCloseTap,
    this.dotColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFE9ECF2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasDot) ...[
            Container(
              width: 6.r,
              height: 6.r,
              decoration: BoxDecoration(
                color: dotColor ?? AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6.w),
          ],
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF4B5563),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (hasCloseIcon) ...[
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: onCloseTap,
              behavior: HitTestBehavior.opaque,
              child: Icon(
                Icons.close_rounded,
                size: 14.r,
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
