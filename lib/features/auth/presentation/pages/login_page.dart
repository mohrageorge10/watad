import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/models/auth_request_models.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/auth/presentation/cubit/auth_state.dart';
import 'package:watad/features/auth/presentation/view/sections/login_footer_section.dart';
import 'package:watad/features/auth/presentation/view/sections/login_form_section.dart';
import 'package:watad/features/auth/presentation/view/sections/login_header_section.dart';
import 'package:watad/features/auth/presentation/view/widgets/remember_me_confirmation_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _executeLogin(BuildContext cubitContext, {required bool rememberMe}) {
    cubitContext.read<AuthCubit>().login(
          LoginRequestModel(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            rememberMe: rememberMe,
          ),
        );
  }

  void _handleLogin(BuildContext cubitContext) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_rememberMe) {
      SmartDialog.show(
        builder: (_) {
          return RememberMeConfirmationDialog(
            onEnableAndLogin: () {
              SmartDialog.dismiss();
              setState(() {
                _rememberMe = true;
              });
              _executeLogin(cubitContext, rememberMe: true);
            },
            onContinueWithout: () {
              SmartDialog.dismiss();
              _executeLogin(cubitContext, rememberMe: false);
            },
            onCancel: () {
              SmartDialog.dismiss();
            },
          );
        },
      );
      return;
    }

    _executeLogin(cubitContext, rememberMe: true);
  }

  void _handleForgetPassword() {
    context.push(AppRoutes.forgetPassScreen);
  }

  void _handleCreateAccount() {
    context.push(AppRoutes.signUpScreen);
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
              if (state is LoginSuccessState) {
                final msg = state.response.message.isNotEmpty
                    ? state.response.message
                    : 'Welcome back to Watad!';
                AppToast.showSuccess(context, msg);
                context.go(AppRoutes.projectDashboard);
              } else if (state is AuthErrorState) {
                AppToast.showError(context, state.message);
              }
            },
            builder: (context, state) {
              final bool isLoading = state is AuthLoading;

              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 16.h,
                  left: 24.w,
                  right: 24.w,
                  bottom: 30.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LoginHeaderSection(),
                    LoginFormSection(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      rememberMe: _rememberMe,
                      isLoading: isLoading,
                      onRememberMeChanged: (val) {
                        setState(() {
                          _rememberMe = val ?? false;
                        });
                      },
                      onForgetPasswordPressed: _handleForgetPassword,
                      onLoginPressed: () => _handleLogin(context),
                    ),
                    LoginFooterSection(
                      onCreateAccountPressed: _handleCreateAccount,
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
