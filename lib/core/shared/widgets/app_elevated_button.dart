import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height,
    this.backgroundColor,
    this.textStyle,
    this.borderRadius,
    this.padding,
  });

  final String title;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool isDisabled;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final bool disabled = isDisabled || isLoading;

    return SizedBox(
      width: width ?? double.infinity,
      height: (height ?? 52).h,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          backgroundColor: backgroundColor ?? AppColors.primary700,
          disabledBackgroundColor: AppColors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular((borderRadius ?? 16).r),
          ),
          elevation: 0,
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leftIcon != null) ...[
                    leftIcon!,
                    SizedBox(width: 8.w),
                  ],
                  Text(
                    title,
                    style: textStyle ??
                        (disabled
                            ? AppTextStyles.btnGrey600
                            : AppTextStyles.btnWhite600),
                  ),
                  if (rightIcon != null) ...[
                    SizedBox(width: 8.w),
                    rightIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}

typedef AppButton = AppElevatedButton;
