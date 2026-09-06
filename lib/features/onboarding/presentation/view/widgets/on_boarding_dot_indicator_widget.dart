import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class OnBoardingDotIndicatorWidget extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const OnBoardingDotIndicatorWidget({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) {
          final bool isActive = index == currentIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: isActive ? 24.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary700 : AppColors.signUp,
              borderRadius: BorderRadius.circular(4.r),
            ),
          );
        },
      ),
    );
  }
}
