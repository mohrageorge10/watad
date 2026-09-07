import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/presentation/view/widgets/divider_with_text_widget.dart';

class WelcomeFooterSection extends StatelessWidget {
  const WelcomeFooterSection({
    super.key,
    required this.onLoginPressed,
  });

  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const DividerWithTextWidget(
          text: 'OR',
          textColor: Color(0xFF8E8E93),
          lineColor: Color(0xFFC6C6C8),
        ),
        SizedBox(height: 30.h),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'Inter',
              ),
              children: [
                const TextSpan(
                  text: 'Or login with ',
                  style: TextStyle(
                    color: Color(0xFF1D1D1F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'your account.',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onLoginPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
