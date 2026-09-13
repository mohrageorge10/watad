import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class FuturePlanView extends StatelessWidget {
  const FuturePlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Future Plan',
          style: AppTextStyles.font18SemiBoldDark.copyWith(
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                size: 80.sp,
                color: AppColors.primary,
              ),
              SizedBox(height: 24.h),
              Text(
                'Coming Soon',
                style: AppTextStyles.font24Bold.copyWith(
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'This feature is currently under development. Stay tuned for updates on our smart planning tools.',
                textAlign: TextAlign.center,
                style: AppTextStyles.font14Medium.copyWith(
                  color: AppColors.grey500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
