import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';

class AllChangeOrdersShimmer extends StatelessWidget {
  const AllChangeOrdersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: AppShimmerBox(height: 120)),
              SizedBox(width: 8.w),
              const Expanded(child: AppShimmerBox(height: 120)),
              SizedBox(width: 8.w),
              const Expanded(child: AppShimmerBox(height: 120)),
              SizedBox(width: 8.w),
              const Expanded(child: AppShimmerBox(height: 120)),
            ],
          ),
          SizedBox(height: 24.h),
          const AppShimmerBox(height: 180),
          SizedBox(height: 12.h),
          const AppShimmerBox(height: 180),
        ],
      ),
    );
  }
}
