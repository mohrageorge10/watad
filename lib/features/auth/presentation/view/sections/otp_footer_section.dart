import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class OtpFooterSection extends StatelessWidget {
  const OtpFooterSection({
    super.key,
    required this.remainingSeconds,
    required this.onResendCodePressed,
  });

  final int remainingSeconds;
  final VoidCallback onResendCodePressed;

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSecs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$remainingSecs';
  }

  @override
  Widget build(BuildContext context) {
    final bool canResend = remainingSeconds == 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive OTP? ",
          style: TextStyle(
            fontSize: 14.sp,
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
                fontSize: 14.sp,
                fontFamily: 'Inter',
                color: canResend ? AppColors.primary : AppColors.grey400,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
