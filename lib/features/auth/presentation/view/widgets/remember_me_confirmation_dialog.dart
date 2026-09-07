import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class RememberMeConfirmationDialog extends StatelessWidget {
  const RememberMeConfirmationDialog({
    super.key,
    required this.onEnableAndLogin,
    required this.onContinueWithout,
    required this.onCancel,
  });

  final VoidCallback onEnableAndLogin;
  final VoidCallback onContinueWithout;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon Container
          Container(
            width: 56.w,
            height: 56.h,
            decoration: const BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_clock_outlined,
              color: AppColors.primary700,
              size: 28.sp,
            ),
          ),
          SizedBox(height: 16.h),

          // Title
          Text(
            'Stay Logged In?',
            style: AppTextStyle.font16SemiBold.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.smallText,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),

          // Description
          Text(
            "You haven't checked 'Remember me'. You will be logged out automatically when you close the app.\nWould you like to stay logged in?",
            style: AppTextStyle.font14Regular.copyWith(
              color: AppColors.grey600,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),

          // Option 1: Enable & Login
          AppElevatedButton(
            title: 'Enable & Log In',
            onPressed: onEnableAndLogin,
            height: 46,
            borderRadius: 12,
          ),
          SizedBox(height: 10.h),

          // Option 2: Continue without Remember Me
          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: OutlinedButton(
              onPressed: onContinueWithout,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.grey300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Continue without Remember Me',
                style: AppTextStyle.font14Medium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey800,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Option 3: Cancel
          TextButton(
            onPressed: onCancel,
            child: Text(
              'Cancel',
              style: AppTextStyle.font12Regular.copyWith(
                color: AppColors.deactivation,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
