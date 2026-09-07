import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/auth/presentation/cubit/auth_state.dart';
import 'package:watad/features/auth/presentation/view/sections/reset_password_form_section.dart';
import 'package:watad/features/auth/presentation/view/sections/reset_password_header_section.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    this.email,
    this.otp,
  });

  final String? email;
  final String? otp;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleResetPassword(BuildContext cubitContext) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    cubitContext.read<AuthCubit>().resetPassword(
          ResetPasswordRequestModel(
            email: widget.email ?? '',
            resetToken: widget.otp ?? '',
            newPassword: _newPasswordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.signUp,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1D1D1F)),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is ResetPasswordSuccessState) {
                AppToast.showSuccess(
                  context,
                  state.message.isNotEmpty
                      ? state.message
                      : 'Your password has been reset successfully!',
                );
                context.go(AppRoutes.loginScreen);
              } else if (state is AuthErrorState) {
                AppToast.showError(context, state.message);
              }
            },
            builder: (context, state) {
              final bool isLoading = state is AuthLoading;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ResetPasswordHeaderSection(),
                    ResetPasswordFormSection(
                      formKey: _formKey,
                      newPasswordController: _newPasswordController,
                      confirmPasswordController: _confirmPasswordController,
                      isLoading: isLoading,
                      onDonePressed: () => _handleResetPassword(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
