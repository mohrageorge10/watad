import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Welcome',
          style: TextStyle(
            color: const Color(0xFF1D1D1F),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}
