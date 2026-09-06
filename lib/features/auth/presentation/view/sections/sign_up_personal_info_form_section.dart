import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/utils/app_validators.dart';
import 'package:watad/features/auth/presentation/view/widgets/auth_text_field_widget.dart';

class SignUpPersonalInfoFormSection extends StatelessWidget {
  const SignUpPersonalInfoFormSection({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.fullNameController,
    required this.phoneController,
    required this.onContinuePressed,
    this.isLoading = false,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController fullNameController;
  final TextEditingController phoneController;
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
            controller: fullNameController,
            hintText: 'Full Name',
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (val) => AppValidators.validateName(val, fieldName: 'Full Name'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            prefixIcon: Icon(
              Icons.person_outline_rounded,
              color: AppColors.grey500,
              size: 22.sp,
            ),
          ),
          SizedBox(height: 24.h),
          AuthTextFieldWidget(
            controller: phoneController,
            hintText: 'Phone Number',
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            validator: AppValidators.validatePhone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            prefixIcon: Icon(
              Icons.phone_outlined,
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
        ],
      ),
    );
  }
}
