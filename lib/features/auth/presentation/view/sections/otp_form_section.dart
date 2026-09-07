import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';

class OtpFormSection extends StatelessWidget {
  const OtpFormSection({
    super.key,
    required this.otpController,
    required this.onContinuePressed,
    this.onCompleted,
    this.isLoading = false,
  });

  final TextEditingController otpController;
  final VoidCallback onContinuePressed;
  final ValueChanged<String>? onCompleted;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 54.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1D1D1F),
        fontFamily: 'Inter',
      ),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.transparent),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppColors.white100,
        border: Border.all(color: AppColors.accept, width: 1.5),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Pinput(
            length: 6,
            controller: otpController,
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: focusedPinTheme,
            submittedPinTheme: submittedPinTheme,
            onCompleted: onCompleted,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(height: 32.h),
        AppElevatedButton(
          title: 'Continue',
          isLoading: isLoading,
          onPressed: onContinuePressed,
          backgroundColor: AppColors.primary,
          borderRadius: 12,
          height: 54,
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white100,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}
