import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/presentation/view/widgets/divider_with_text_widget.dart';

class LoginFooterSection extends StatelessWidget {
  const LoginFooterSection({
    super.key,
    required this.onCreateAccountPressed,
  });

  final VoidCallback onCreateAccountPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32.h),
        const DividerWithTextWidget(
          text: 'OR',
          textColor: Color(0xFF8E8E93),
          lineColor: Color(0xFFC6C6C8),
        ),
        SizedBox(height: 40.h),
        Center(
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Inter',
              ),
              children: [
                const TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(
                    color: Color(0xFF1D1D1F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Create an account',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onCreateAccountPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
