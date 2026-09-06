import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/utils/app_validators.dart';
import 'package:watad/features/auth/presentation/view/widgets/auth_text_field_widget.dart';

class SignUpPasswordFormSection extends StatelessWidget {
  const SignUpPasswordFormSection({
    super.key,
    required this.formKey,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onContinuePressed,
    this.isLoading = false,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onContinuePressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextFieldWidget(
            controller: passwordController,
            hintText: 'Password',
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: AppValidators.validatePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            suffixIcon: Icon(
              Icons.lock_outline_rounded,
              color: AppColors.grey500,
              size: 22.sp,
            ),
          ),
          SizedBox(height: 24.h),
          AuthTextFieldWidget(
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: (val) => AppValidators.validateConfirmPassword(
              val,
              passwordController.text,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            suffixIcon: Icon(
              Icons.lock_outline_rounded,
              color: AppColors.grey500,
              size: 22.sp,
            ),
          ),
          SizedBox(height: 40.h),
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
          SizedBox(height: 24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletItem('At least 6 characters'),
              SizedBox(height: 8.h),
              _buildBulletItem('Should include numbers & special characters'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 5.w,
          height: 5.h,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
