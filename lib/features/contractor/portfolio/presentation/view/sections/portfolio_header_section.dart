import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';

class PortfolioHeaderSection extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const PortfolioHeaderSection({
    super.key,
    this.onBackTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        left: 20.w,
        right: 20.w,
        bottom: 56.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          IconButton(
            onPressed: onBackTap ?? () {
              if (context.canPop()) {
                context.pop();
              }
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.white100,
              size: 20.r,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 24.r,
          ),

          // Title
          Text(
            'Portfolio Projects',
            style: TextStyle(
              color: AppColors.white100,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Settings Button
          IconButton(
            onPressed: onSettingsTap,
            icon: Icon(
              Icons.settings_outlined,
              color: AppColors.white100,
              size: 22.r,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            splashRadius: 24.r,
          ),
        ],
      ),
    );
  }
}
