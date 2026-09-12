import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class PortfolioShowcaseCard extends StatelessWidget {
  final VoidCallback? onAddProjectTap;

  const PortfolioShowcaseCard({
    super.key,
    this.onAddProjectTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Hardhat / Construction Icon
          Icon(
            Icons.engineering_outlined,
            color: AppColors.primary,
            size: 36.r,
          ),

          SizedBox(width: 14.w),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Showcase Your Best Work',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Add your completed projects to your portfolio and attract more opportunities.',
                  style: TextStyle(
                    color: const Color(0xFF1D1D1F),
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Trailing Outlined Button
          OutlinedButton(
            onPressed: onAddProjectTap,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: AppColors.primary,
                width: 1.5.w,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 8.h,
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Add Project',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
