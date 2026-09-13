import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_colors.dart';

class ProjectDashboardShimmerSection extends StatelessWidget {
  const ProjectDashboardShimmerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Hero Card Shimmer
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppShimmerBox(width: 150.w, height: 18.h, borderRadius: 4),
                    AppShimmerBox(width: 60.w, height: 20.h, borderRadius: 10),
                  ],
                ),
                SizedBox(height: 8.h),
                AppShimmerBox(width: 100.w, height: 12.h, borderRadius: 4),
                SizedBox(height: 16.h),
                AppShimmerBox(
                    width: double.infinity, height: 8.h, borderRadius: 4),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // 2. Progress Overview Shimmer
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                AppShimmerBox(width: 70.r, height: 70.r, borderRadius: 35),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppShimmerBox(
                                width: 80.w, height: 12.h, borderRadius: 4),
                            AppShimmerBox(
                                width: 30.w, height: 12.h, borderRadius: 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // 3. Active Milestone Card Shimmer
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmerBox(width: 120.w, height: 16.h, borderRadius: 4),
                SizedBox(height: 10.h),
                AppShimmerBox(width: 200.w, height: 14.h, borderRadius: 4),
                SizedBox(height: 12.h),
                AppShimmerBox(
                    width: double.infinity, height: 6.h, borderRadius: 3),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // 4. Daily Logs Header & Items Shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppShimmerBox(width: 100.w, height: 16.h, borderRadius: 4),
              AppShimmerBox(width: 60.w, height: 14.h, borderRadius: 4),
            ],
          ),
          SizedBox(height: 12.h),
          ...List.generate(
            2,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: AppShimmerBox(
                width: double.infinity,
                height: 70.h,
                borderRadius: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
