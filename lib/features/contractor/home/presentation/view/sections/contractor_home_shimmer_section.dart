import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_colors.dart';

class ContractorHomeShimmerSection extends StatelessWidget {
  const ContractorHomeShimmerSection({super.key});

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
            padding: EdgeInsets.fromLTRB(24.w, 50.h, 24.w, 60.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.85),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBox(width: 160.w, height: 22.h, borderRadius: 6),
                    SizedBox(height: 8.h),
                    AppShimmerBox(width: 220.w, height: 14.h, borderRadius: 4),
                  ],
                ),
                Row(
                  children: [
                    AppShimmerBox(width: 28.r, height: 28.r, borderRadius: 14),
                    SizedBox(width: 12.w),
                    AppShimmerBox(width: 40.r, height: 40.r, borderRadius: 20),
                  ],
                ),
              ],
            ),
          ),

          // Complete Profile Card Shimmer
          Transform.translate(
            offset: Offset(0, -28.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    AppShimmerBox(width: 32.r, height: 32.r, borderRadius: 8),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBox(
                              width: double.infinity, height: 14.h, borderRadius: 4),
                          SizedBox(height: 6.h),
                          AppShimmerBox(width: 140.w, height: 14.h, borderRadius: 4),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    AppShimmerBox(width: 32.r, height: 32.r, borderRadius: 16),
                  ],
                ),
              ),
            ),
          ),

          // Active Projects Header Shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppShimmerBox(width: 130.w, height: 18.h, borderRadius: 6),
                AppShimmerBox(width: 70.w, height: 16.h, borderRadius: 6),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Horizontal Project Card Shimmer Items
          ...List.generate(
            2,
            (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    AppShimmerBox(width: 64.w, height: 64.h, borderRadius: 8),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBox(width: 140.w, height: 16.h, borderRadius: 4),
                          SizedBox(height: 6.h),
                          AppShimmerBox(width: 100.w, height: 12.h, borderRadius: 4),
                          SizedBox(height: 6.h),
                          AppShimmerBox(width: 80.w, height: 12.h, borderRadius: 4),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppShimmerBox(width: 60.w, height: 20.h, borderRadius: 10),
                        SizedBox(height: 8.h),
                        AppShimmerBox(width: 45.w, height: 12.h, borderRadius: 4),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Marketplace Shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: AppShimmerBox(
              width: double.infinity,
              height: 90.h,
              borderRadius: 16,
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
