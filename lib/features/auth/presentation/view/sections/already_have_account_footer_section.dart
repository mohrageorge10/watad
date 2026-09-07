import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class AlreadyHaveAccountFooterSection extends StatelessWidget {
  const AlreadyHaveAccountFooterSection({
    super.key,
    required this.onLoginPressed,
  });

  final VoidCallback onLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'Inter',
          ),
          children: [
            const TextSpan(
              text: 'Already have an account? ',
              style: TextStyle(
                color: Color(0xFF1D1D1F),
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: 'Login',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()..onTap = onLoginPressed,
            ),
          ],
        ),
      ),
    );
  }
}
