import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';

class WelcomeActionsSection extends StatelessWidget {
  const WelcomeActionsSection({
    super.key,
    required this.onSignUpPressed,
  });

  final VoidCallback onSignUpPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppElevatedButton(
          title: 'Create Account',
          leftIcon: Icon(
            Icons.mail_outline_rounded,
            color: AppColors.white100,
            size: 22.sp,
          ),
          onPressed: onSignUpPressed,
          backgroundColor: AppColors.primary,
          borderRadius: 12,
          height: 54,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
