import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_colors.dart';

class PortfolioShimmerSection extends StatelessWidget {
  final VoidCallback? onBackTap;

  const PortfolioShimmerSection({
    super.key,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Shimmer
          Container(
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
                IconButton(
                  onPressed: onBackTap,
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.white100,
                    size: 20.r,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                AppShimmerBox(
                  width: 140.w,
                  height: 20.h,
                  borderRadius: 6,
                ),
                Icon(
                  Icons.settings_outlined,
                  color: AppColors.white100.withValues(alpha: 0.5),
                  size: 22.r,
                ),
              ],
            ),
          ),

          // Showcase Card Shimmer
          Transform.translate(
            offset: Offset(0, -32.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.all(20.r),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16.r,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    AppShimmerBox(
                      width: double.infinity,
                      height: 18.h,
                      borderRadius: 6,
                    ),
                    SizedBox(height: 12.h),
                    AppShimmerBox(
                      width: 200.w,
                      height: 14.h,
                      borderRadius: 4,
                    ),
                    SizedBox(height: 20.h),
                    AppShimmerBox(
                      width: double.infinity,
                      height: 48.h,
                      borderRadius: 12,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Projects List Header Shimmer
          Transform.translate(
            offset: Offset(0, -16.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppShimmerBox(
                        width: 110.w,
                        height: 18.h,
                        borderRadius: 6,
                      ),
                      AppShimmerBox(
                        width: 65.w,
                        height: 14.h,
                        borderRadius: 4,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Cards Shimmer (3 items)
                  ...List.generate(
                    3,
                    (index) => Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: AppColors.white100,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBox(
                            width: 80.w,
                            height: 80.w,
                            borderRadius: 12,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppShimmerBox(
                                  width: 140.w,
                                  height: 16.h,
                                  borderRadius: 4,
                                ),
                                SizedBox(height: 8.h),
                                AppShimmerBox(
                                  width: 100.w,
                                  height: 12.h,
                                  borderRadius: 4,
                                ),
                                SizedBox(height: 6.h),
                                AppShimmerBox(
                                  width: 80.w,
                                  height: 12.h,
                                  borderRadius: 4,
                                ),
                              ],
                            ),
                          ),
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
