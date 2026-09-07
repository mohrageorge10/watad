import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/presentation/view/widgets/custom_horizontal_stepper.dart';

class SignUpHeaderSection extends StatelessWidget {
  const SignUpHeaderSection({
    super.key,
    required this.currentStep,
    this.totalSteps = 4,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),
        SizedBox(height: 32.h),
        CustomHorizontalStepper(
          currentStep: currentStep,
          totalSteps: totalSteps,
          marginBottom: 48,
        ),
      ],
    );
  }
}
