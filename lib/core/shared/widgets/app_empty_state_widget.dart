import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class AppEmptyStateWidget extends StatelessWidget {
  const AppEmptyStateWidget({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.buttonTitle,
    this.onButtonPressed,
  });

  final String title;
  final String? message;
  final Widget? icon;
  final String? buttonTitle;
  final VoidCallback? onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon ??
                Icon(
                  Icons.inbox_outlined,
                  size: 72.r,
                  color: AppColors.grey400,
                ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.font16SemiBold.copyWith(
                color: AppColors.grey800,
              ),
            ),
            if (message != null) ...[
              SizedBox(height: 8.h),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.grey500,
                ),
              ),
            ],
            if (buttonTitle != null && onButtonPressed != null) ...[
              SizedBox(height: 24.h),
              AppElevatedButton(
                title: buttonTitle!,
                onPressed: onButtonPressed,
                width: 200.w,
                height: 44,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
