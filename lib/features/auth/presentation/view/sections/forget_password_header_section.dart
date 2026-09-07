import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class ForgetPasswordHeaderSection extends StatelessWidget {
  const ForgetPasswordHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forget Password',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Please enter your email to send reset code',
          style: TextStyle(
            color: const Color(0xFF1D1D1F),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}
