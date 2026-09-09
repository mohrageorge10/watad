import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_colors.dart';

class MarketplaceShimmerSection extends StatelessWidget {
  final int itemCount;

  const MarketplaceShimmerSection({
    super.key,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: List.generate(
          itemCount,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: AppColors.white100,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: const Color(0xFFE5E5EA),
                  width: 1.w,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top indicators shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AppShimmerBox(
                        width: 55.w,
                        height: 20.h,
                        borderRadius: 12,
                      ),
                      SizedBox(width: 8.w),
                      AppShimmerBox(
                        width: 20.r,
                        height: 20.r,
                        borderRadius: 4,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Body shimmer
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmerBox(
                        width: 80.r,
                        height: 80.r,
                        borderRadius: 12,
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppShimmerBox(
                              width: double.infinity,
                              height: 16.h,
                              borderRadius: 4,
                            ),
                            SizedBox(height: 8.h),
                            AppShimmerBox(
                              width: 120.w,
                              height: 12.h,
                              borderRadius: 4,
                            ),
                            SizedBox(height: 10.h),
                            AppShimmerBox(
                              width: 160.w,
                              height: 12.h,
                              borderRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // Footer shimmer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBox(
                            width: 60.w,
                            height: 10.h,
                            borderRadius: 4,
                          ),
                          SizedBox(height: 4.h),
                          AppShimmerBox(
                            width: 100.w,
                            height: 16.h,
                            borderRadius: 4,
                          ),
                        ],
                      ),
                      AppShimmerBox(
                        width: 95.w,
                        height: 34.h,
                        borderRadius: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
