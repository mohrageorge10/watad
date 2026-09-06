import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class CustomHorizontalStepper extends StatelessWidget {
  const CustomHorizontalStepper({
    super.key,
    required this.currentStep,
    this.totalSteps = 4,
    this.widthFactor = 0.85,
    this.marginBottom = 32,
  });

  final int currentStep;
  final int totalSteps;
  final double widthFactor;
  final double marginBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: marginBottom.h),
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _buildStepItems(),
        ),
      ),
    );
  }

  List<Widget> _buildStepItems() {
    final List<Widget> items = [];

    for (int i = 1; i <= totalSteps; i++) {
      final bool isCompletedOrActive = i <= currentStep;
      final bool isLineActive = i < currentStep;

      // Step Circle
      items.add(
        Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompletedOrActive
                ? AppColors.primary
                : const Color(0xFFE5E5EA),
          ),
          alignment: Alignment.center,
          child: Text(
            '$i',
            style: TextStyle(
              color: isCompletedOrActive
                  ? AppColors.white100
                  : const Color(0xFF1D1D1F),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
      );

      // Connecting Line between steps
      if (i < totalSteps) {
        items.add(
          Expanded(
            child: Container(
              height: 3.h,
              color: isLineActive
                  ? AppColors.primary
                  : const Color(0xFFE5E5EA),
            ),
          ),
        );
      }
    }

    return items;
  }
}
