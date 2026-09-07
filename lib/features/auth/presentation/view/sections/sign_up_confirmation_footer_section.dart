import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class SignUpConfirmationFooterSection extends StatelessWidget {
  const SignUpConfirmationFooterSection({
    super.key,
    required this.remainingSeconds,
    required this.onResendCodePressed,
    this.onTermsPressed,
    this.onPrivacyPressed,
  });

  final int remainingSeconds;
  final VoidCallback onResendCodePressed;
  final VoidCallback? onTermsPressed;
  final VoidCallback? onPrivacyPressed;

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSecs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSecs';
  }

  @override
  Widget build(BuildContext context) {
    final bool canResend = remainingSeconds == 0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive OTP? ",
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Inter',
                color: const Color(0xFF1D1D1F),
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: canResend ? onResendCodePressed : null,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                child: Text(
                  canResend
                      ? 'Re-send Code'
                      : 'Re-send in ${_formatDuration(remainingSeconds)}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Inter',
                    color: canResend ? AppColors.primary : AppColors.grey400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 64.h),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'Inter',
                height: 1.5,
              ),
              children: [
                const TextSpan(
                  text: 'By clicking create account you agree to\nOur ',
                  style: TextStyle(
                    color: Color(0xFF1D1D1F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Terms Of Use',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onTermsPressed,
                ),
                const TextSpan(
                  text: ' and ',
                  style: TextStyle(
                    color: Color(0xFF1D1D1F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onPrivacyPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
