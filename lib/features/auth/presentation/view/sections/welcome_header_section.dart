import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/constants/app_images.dart';
import 'package:watad/core/theme/app_colors.dart';

class WelcomeHeaderSection extends StatelessWidget {
  const WelcomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Watad',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 48.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Smart Construction Management Platform',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF1D1D1F),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 40.h),
        Hero(
          tag: 'app_logo',
          child: Image.asset(
            Assets.imagesLogo,
            width: 120.w,
            height: 120.h,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 40.h),
        Text(
          'Welcome to Watad',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
