import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/presentation/view/widgets/social_auth_button_widget.dart';

class WelcomeActionsSection extends StatelessWidget {
  const WelcomeActionsSection({
    super.key,
    required this.onGooglePressed,
    required this.onFacebookPressed,
    required this.onEmailPressed,
    this.isGoogleLoading = false,
    this.isFacebookLoading = false,
  });

  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;
  final VoidCallback onEmailPressed;
  final bool isGoogleLoading;
  final bool isFacebookLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SocialAuthButtonWidget(
          title: '  continue with Google',
          icon: Container(
            padding: EdgeInsets.all(4.r),
            decoration: const BoxDecoration(
              color: AppColors.white100,
              shape: BoxShape.circle,
            ),
            child: Text(
              'G',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w900,
                fontSize: 18.sp,
                fontFamily: 'Inter',
              ),
            ),
          ),
          isLoading: isGoogleLoading,
          onPressed: onGooglePressed,
          backgroundColor: AppColors.primary,
          textColor: AppColors.white100,
          borderRadius: 12,
        ),
        SizedBox(height: 16.h),
        SocialAuthButtonWidget(
          title: 'continue with Facebook',
          icon: Icon(
            Icons.facebook_sharp,
            color: AppColors.white100,
            size: 26.sp,
          ),
          isLoading: isFacebookLoading,
          onPressed: onFacebookPressed,
          backgroundColor: AppColors.primary,
          textColor: AppColors.white100,
          borderRadius: 12,
        ),
        SizedBox(height: 16.h),
        SocialAuthButtonWidget(
          title: 'continue with Email',
          icon: Icon(
            Icons.mail_outline_rounded,
            color: AppColors.white100,
            size: 22.sp,
          ),
          onPressed: onEmailPressed,
          backgroundColor: AppColors.primary,
          textColor: AppColors.white100,
          borderRadius: 12,
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
