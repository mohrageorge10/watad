import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class EditProfileChipWidget extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool hasCloseIcon;
  final VoidCallback? onTap;
  final VoidCallback? onCloseTap;

  const EditProfileChipWidget({
    super.key,
    required this.text,
    this.isActive = true,
    this.hasCloseIcon = false,
    this.onTap,
    this.onCloseTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive ? AppColors.primary : const Color(0xFFE5E5EA);
    final textColor = isActive ? AppColors.white100 : const Color(0xFF8E8E93);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 13.sp,
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
                  size: 15.r,
                  color: textColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
