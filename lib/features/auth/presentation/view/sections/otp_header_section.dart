import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class OtpHeaderSection extends StatelessWidget {
  const OtpHeaderSection({
    super.key,
    this.email,
  });

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OTP',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          email != null && email!.isNotEmpty
              ? 'Enter code sent to $email'
              : 'Enter code sent to your email',
          style: TextStyle(
            color: const Color(0xFF1D1D1F),
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}
