import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/utils/app_validators.dart';
import 'package:watad/features/auth/presentation/view/widgets/auth_text_field_widget.dart';

class ResetPasswordFormSection extends StatelessWidget {
  const ResetPasswordFormSection({
    super.key,
    required this.formKey,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onDonePressed,
    this.isLoading = false,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onDonePressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextFieldWidget(
            controller: newPasswordController,
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
              newPasswordController.text,
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
            title: 'Done',
            isLoading: isLoading,
            onPressed: onDonePressed,
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
        ],
      ),
    );
  }
}
