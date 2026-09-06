import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class SignUpStepperWidget extends StatelessWidget {
  const SignUpStepperWidget({
    super.key,
    required this.currentStep,
    this.totalSteps = 4,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final bool isActive = (index + 1) <= currentStep;
        return Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            height: 6.h,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : const Color(0xFFE5E5EA),
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
        );
      }),
    );
  }
}
