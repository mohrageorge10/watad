import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/data/models/role_model.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/auth/presentation/cubit/auth_state.dart';
import 'package:watad/features/auth/presentation/view/sections/sign_up_header_section.dart';
import 'package:watad/features/auth/presentation/view/sections/sign_up_password_form_section.dart';

class SignUpPasswordPage extends StatefulWidget {
  const SignUpPasswordPage({
    super.key,
    this.role,
    this.email,
    this.fullName,
    this.phone,
  });

  final RoleModel? role;
  final String? email;
  final String? fullName;
  final String? phone;

  @override
  State<SignUpPasswordPage> createState() => _SignUpPasswordPageState();
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleContinue(BuildContext cubitContext) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    cubitContext.read<AuthCubit>().register(
          RegisterRequestModel(
            fullName: widget.fullName ?? '',
            email: widget.email ?? '',
            phoneNumber: widget.phone ?? '',
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
            userType: widget.role?.userType ?? 0,
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
              if (state is RegisterSuccessState) {
                AppToast.showSuccess(
                  context,
                  state.response.message.isNotEmpty
                      ? state.response.message
                      : 'Registration successful! Please confirm your email.',
                );
                context.push(
                  AppRoutes.signUpConfirmation,
                  extra: {
                    'role': widget.role,
                    'email': widget.email,
                    'fullName': widget.fullName,
                    'phone': widget.phone,
                    'password': _passwordController.text,
                  },
                );
              } else if (state is AuthErrorState) {
                AppToast.showError(context, state.message);
              }
            },
            builder: (context, state) {
              final bool isLoading = state is AuthLoading;

              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  bottom: 24.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SignUpHeaderSection(currentStep: 3),
                    Text(
                      'Password',
                      style: TextStyle(
                        color: const Color(0xFF1D1D1F),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SignUpPasswordFormSection(
                      formKey: _formKey,
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      isLoading: isLoading,
                      onContinuePressed: () => _handleContinue(context),
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
