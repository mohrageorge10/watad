import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class AppChipWidget extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool hasDot;
  final bool hasCloseIcon;
  final Color? dotColor;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final VoidCallback? onCloseTap;
  final EdgeInsetsGeometry? padding;

  const AppChipWidget({
    super.key,
    required this.label,
    this.isActive = true,
    this.hasDot = false,
    this.hasCloseIcon = false,
    this.dotColor,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.onCloseTap,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBgColor = backgroundColor ??
        (isActive ? AppColors.primary : const Color(0xFFE9ECF2));

    final effectiveTextColor = textColor ??
        (isActive
            ? AppColors.white100
            : const Color(0xFF4B5563));

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: effectiveBgColor,
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
                  color: dotColor ?? (isActive ? AppColors.white100 : AppColors.primary),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: TextStyle(
                color: effectiveTextColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
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
                  color: effectiveTextColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
