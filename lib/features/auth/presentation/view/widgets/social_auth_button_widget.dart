import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class SocialAuthButtonWidget extends StatelessWidget {
  const SocialAuthButtonWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.height,
    this.isLoading = false,
  });

  final String title;
  final Widget icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? height;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: (height ?? 54).h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          disabledBackgroundColor: AppColors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular((borderRadius ?? 12).r),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
        ),
        child: isLoading
            ? SizedBox(
                height: 22.h,
                width: 22.h,
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white100),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  SizedBox(width: 12.w),
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor ?? AppColors.white100,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
