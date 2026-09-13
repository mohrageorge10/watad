import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_colors.dart';

class MilestoneLogsShimmerSection extends StatelessWidget {
  const MilestoneLogsShimmerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Project & Milestone Header Card Shimmer
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmerBox(width: 44.r, height: 44.r, borderRadius: 12),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppShimmerBox(
                              width: 140.w, height: 16.h, borderRadius: 4),
                          AppShimmerBox(
                              width: 50.w, height: 20.h, borderRadius: 10),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      AppShimmerBox(
                          width: 180.w, height: 14.h, borderRadius: 4),
                      SizedBox(height: 8.h),
                      AppShimmerBox(
                          width: 120.w, height: 12.h, borderRadius: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // 2. Filter Chips Shimmer
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: List.generate(
                4,
                (index) => Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: AppShimmerBox(
                    width: index == 3 ? 70.w : 90.w,
                    height: 32.h,
                    borderRadius: 20,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // 3. Timeline Items Shimmer
          ...List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Node indicator
                  Column(
                    children: [
                      AppShimmerBox(width: 28.r, height: 28.r, borderRadius: 14),
                      SizedBox(height: 6.h),
                      AppShimmerBox(width: 2.w, height: 90.h, borderRadius: 1),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  // Card body
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(14.r),
                      decoration: BoxDecoration(
                        color: AppColors.white100,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              AppShimmerBox(
                                  width: 40.r, height: 40.r, borderRadius: 8),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppShimmerBox(
                                        width: 120.w,
                                        height: 14.h,
                                        borderRadius: 4),
                                    SizedBox(height: 6.h),
                                    AppShimmerBox(
                                        width: 80.w,
                                        height: 12.h,
                                        borderRadius: 4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          AppShimmerBox(
                              width: double.infinity,
                              height: 12.h,
                              borderRadius: 4),
                          SizedBox(height: 6.h),
                          AppShimmerBox(
                              width: 180.w, height: 12.h, borderRadius: 4),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
