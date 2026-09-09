import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';

class MarketplaceHeaderSection extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final String title;
  final bool showBackButton;

  const MarketplaceHeaderSection({
    super.key,
    this.onBackTap,
    this.onSettingsTap,
    this.title = 'Marketplace',
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16.h,
        left: 24.w,
        right: 24.w,
        bottom: 24.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button (if enabled)
          if (showBackButton)
            IconButton(
              onPressed: onBackTap ??
                  () {
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
            title,
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
