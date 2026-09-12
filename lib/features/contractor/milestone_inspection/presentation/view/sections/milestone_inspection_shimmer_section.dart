import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_colors.dart';

class MilestoneInspectionShimmerSection extends StatelessWidget {
  const MilestoneInspectionShimmerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Card Shimmer
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBox(width: 44.r, height: 44.r, borderRadius: 12),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBox(
                              width: 160.w, height: 16.h, borderRadius: 4),
                          SizedBox(height: 6.h),
                          AppShimmerBox(
                              width: 120.w, height: 12.h, borderRadius: 4),
                        ],
                      ),
                    ),
                    AppShimmerBox(width: 44.r, height: 44.r, borderRadius: 22),
                  ],
                ),
                SizedBox(height: 16.h),
                AppShimmerBox(
                    width: double.infinity, height: 6.h, borderRadius: 3),
                SizedBox(height: 20.h),
                Row(
                  children: List.generate(
                    3,
                    (index) => Expanded(
                      child: Column(
                        children: [
                          AppShimmerBox(
                              width: 20.r, height: 20.r, borderRadius: 10),
                          SizedBox(height: 6.h),
                          AppShimmerBox(
                              width: 40.w, height: 12.h, borderRadius: 4),
                          SizedBox(height: 4.h),
                          AppShimmerBox(
                              width: 50.w, height: 10.h, borderRadius: 4),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // 2. Gallery Header & Grid Shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppShimmerBox(width: 120.w, height: 16.h, borderRadius: 4),
              AppShimmerBox(width: 50.w, height: 14.h, borderRadius: 4),
            ],
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: AppShimmerBox(
                      width: double.infinity,
                      height: double.infinity,
                      borderRadius: 12,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(6.r),
                    child: AppShimmerBox(
                        width: 50.w, height: 10.h, borderRadius: 3),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // 3. Notes Shimmer
          AppShimmerBox(width: 100.w, height: 16.h, borderRadius: 4),
          SizedBox(height: 10.h),
          AppShimmerBox(
            width: double.infinity,
            height: 100.h,
            borderRadius: 16,
          ),

          SizedBox(height: 24.h),

          // 4. Button Shimmer
          AppShimmerBox(
            width: double.infinity,
            height: 52.h,
            borderRadius: 14,
          ),
        ],
      ),
    );
  }
}
