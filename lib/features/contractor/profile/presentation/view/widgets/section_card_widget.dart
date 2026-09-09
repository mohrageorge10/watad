import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class SectionCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final String? actionText;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const SectionCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.actionText,
    this.actionIcon,
    this.onActionTap,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      padding: padding ?? EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 18.r,
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              if (actionText != null || actionIcon != null)
                GestureDetector(
                  onTap: onActionTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (actionIcon != null) ...[
                        Icon(
                          actionIcon,
                          color: AppColors.primary,
                          size: 14.r,
                        ),
                        SizedBox(width: 4.w),
                      ],
                      if (actionText != null)
                        Text(
                          actionText!,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }
}
