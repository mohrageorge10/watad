import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart'; // TODO: عدّل المسار لو AppShimmerBox عندك في مكان تاني

class CurrentProjectOverviewShimmer extends StatelessWidget {
  const CurrentProjectOverviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmerBox(
      width: double.infinity,
      height: 210.h,
      borderRadius: 20,
    );
  }
}
