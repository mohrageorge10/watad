import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // App Bar skeleton
          AppShimmerBox(
            width: double.infinity,
            height: 56.h,
            borderRadius: 16.r,
          ),
          SizedBox(height: 24.h),

          // Blue card skeleton
          AppShimmerBox(
            width: double.infinity,
            height: 180.h,
            borderRadius: 16.r,
          ),
          SizedBox(height: 24.h),

          // 4 Quick access cards skeleton
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => AppShimmerBox(
                width: 76.w,
                height: 90.h,
                borderRadius: 12.r,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Milestones title skeleton
          AppShimmerBox(
            width: 120.w,
            height: 20.h,
            borderRadius: 6.r,
          ),
          SizedBox(height: 16.h),

          // Milestones list skeleton
          ...List.generate(
            2,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: AppShimmerBox(
                width: double.infinity,
                height: 72.h,
                borderRadius: 12.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
