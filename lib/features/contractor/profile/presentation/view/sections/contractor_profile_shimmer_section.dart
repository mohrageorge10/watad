import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_colors.dart';

class ContractorProfileShimmerSection extends StatelessWidget {
  const ContractorProfileShimmerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Shimmer
          Container(
            width: double.infinity,
            height: 160.h,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
          ),
          // Overlapping Profile Card Shimmer
          Transform.translate(
            offset: Offset(0, -45.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AppShimmerBox(
                width: double.infinity,
                height: 100.h,
                borderRadius: 16,
              ),
            ),
          ),
          // Stats Card Shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: AppShimmerBox(
              width: double.infinity,
              height: 70.h,
              borderRadius: 16,
            ),
          ),
          // Tab Bar Shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: AppShimmerBox(
              width: double.infinity,
              height: 44.h,
              borderRadius: 24,
            ),
          ),
          // Section Cards Shimmers
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: AppShimmerBox(
              width: double.infinity,
              height: 120.h,
              borderRadius: 16,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: AppShimmerBox(
              width: double.infinity,
              height: 90.h,
              borderRadius: 16,
            ),
          ),
        ],
      ),
    );
  }
}
