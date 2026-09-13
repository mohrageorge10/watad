import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:watad/features/auth/presentation/view/change_password_otp_view.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/utils/cache_keys.dart';

/// Outer widget that provides the AuthCubit via BlocProvider
class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: const _ChangePasswordContent(),
    );
  }
}

/// Inner widget that has access to AuthCubit via its BuildContext
class _ChangePasswordContent extends StatefulWidget {
  const _ChangePasswordContent();

  @override
  State<_ChangePasswordContent> createState() =>
      _ChangePasswordContentState();
}

class _ChangePasswordContentState extends State<_ChangePasswordContent> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _verifyCurrentPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().verifyCurrentPassword(
            VerifyCurrentPasswordRequestModel(
              currentPassword: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          SmartDialog.showLoading(msg: "Verifying...");
        } else {
          SmartDialog.dismiss(status: SmartStatus.loading);
        }

        if (state is VerifyCurrentPasswordSuccessState) {
          SmartDialog.showToast(state.message);
          final email =
              sl<CacheHelper>().getData(key: CacheKeys.userName) ?? "";
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangePasswordOtpView(email: email),
            ),
          );
        } else if (state is AuthErrorState) {
          SmartDialog.showToast(state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white100,
        appBar: AppBar(
          backgroundColor: AppColors.white100,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: AppColors.primary, size: 24.r),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          title: Text(
            'Change Password',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.r),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Banner
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: AppColors.signUp,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline_rounded,
                            color: AppColors.primary, size: 24.r),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            'For your security, please\nverify your current password.',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.smallText,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Password Field
                  Text(
                    'Current Password *',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.smallText,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: AppTextStyles.font14Medium,
                    decoration: InputDecoration(
                      hintText: 'Enter your current password',
                      hintStyle: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.deactivation,
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        color: AppColors.deactivation,
                        size: 20.r,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.deactivation,
                          size: 20.r,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: AppColors.white100,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.h, horizontal: 16.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide:
                            BorderSide(color: AppColors.grey200, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide:
                            BorderSide(color: AppColors.grey200, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1.5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                            color: AppColors.alert, width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16.h),

                  // Forgot Password Link
                  GestureDetector(
                    onTap: () {
                      // Handle forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Continue Button
                  AppElevatedButton(
                    title: 'Continue',
                    onPressed: _verifyCurrentPassword,
                    width: double.infinity,
                    height: 52,
                    textStyle: AppTextStyles.font16SemiBold.copyWith(
                      color: AppColors.white100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
