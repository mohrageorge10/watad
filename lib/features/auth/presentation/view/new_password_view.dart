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

/// Outer widget that provides the AuthCubit via BlocProvider
class NewPasswordView extends StatelessWidget {
  final String otpCode;

  const NewPasswordView({super.key, required this.otpCode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: _NewPasswordContent(otpCode: otpCode),
    );
  }
}

/// Inner widget that has access to AuthCubit via its BuildContext
class _NewPasswordContent extends StatefulWidget {
  final String otpCode;

  const _NewPasswordContent({required this.otpCode});

  @override
  State<_NewPasswordContent> createState() => _NewPasswordContentState();
}

class _NewPasswordContentState extends State<_NewPasswordContent> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().confirmNewPassword(
            ConfirmNewPasswordRequestModel(
              otpCode: widget.otpCode,
              newPassword: _newPasswordController.text,
              confirmNewPassword: _confirmPasswordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          SmartDialog.showLoading(msg: "Updating Password...");
        } else {
          SmartDialog.dismiss(status: SmartStatus.loading);
        }

        if (state is ConfirmNewPasswordSuccessState) {
          SmartDialog.showToast(state.message);
          // Navigate back to profile
          Navigator.of(context).popUntil((route) => route.isFirst);
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
            icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.r),
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
                  SizedBox(height: 16.h),

                  // New Password Field
                  Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: _obscureNewPassword,
                    style: AppTextStyles.font14Medium,
                    decoration: InputDecoration(
                      hintText: 'Enter new password',
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
                          _obscureNewPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.deactivation,
                          size: 20.r,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureNewPassword = !_obscureNewPassword;
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
                      if (value == null || value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Password must be at least 8 characters long and include\nletters and numbers.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.smallText,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Confirm New Password Field
                  Text(
                    'Confirm New Password',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: AppTextStyles.font14Medium,
                    decoration: InputDecoration(
                      hintText: 'Confirm new password',
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
                          _obscureConfirmPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.deactivation,
                          size: 20.r,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
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
                        return 'Please confirm your new password';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 40.h),

                  // Confirm Button
                  AppElevatedButton(
                    title: 'Confirm',
                    onPressed: _onConfirm,
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
