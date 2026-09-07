import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/utils/app_validators.dart';
import 'package:watad/features/auth/presentation/view/widgets/auth_text_field_widget.dart';
import 'package:watad/features/auth/presentation/view/widgets/remember_me_checkbox_widget.dart';

class LoginFormSection extends StatelessWidget {
  const LoginFormSection({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.onRememberMeChanged,
    required this.onForgetPasswordPressed,
    required this.onLoginPressed,
    this.isLoading = false,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final ValueChanged<bool?> onRememberMeChanged;
  final VoidCallback onForgetPasswordPressed;
  final VoidCallback onLoginPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextFieldWidget(
            controller: emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.validateEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            prefixIcon: Icon(
              Icons.mail_outline_rounded,
              color: AppColors.grey500,
              size: 22.sp,
            ),
          ),
          SizedBox(height: 24.h),
          AuthTextFieldWidget(
            controller: passwordController,
            hintText: 'Password',
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: AppValidators.validatePassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: AppColors.grey500,
              size: 22.sp,
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RememberMeCheckboxWidget(
                value: rememberMe,
                onChanged: onRememberMeChanged,
              ),
              GestureDetector(
                onTap: onForgetPasswordPressed,
                behavior: HitTestBehavior.opaque,
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          AppElevatedButton(
            title: 'Login',
            isLoading: isLoading,
            onPressed: onLoginPressed,
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
