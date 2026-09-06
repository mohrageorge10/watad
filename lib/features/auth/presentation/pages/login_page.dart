import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/presentation/view/sections/login_footer_section.dart';
import 'package:watad/features/auth/presentation/view/sections/login_form_section.dart';
import 'package:watad/features/auth/presentation/view/sections/login_header_section.dart';

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
  bool _isLoading = false;

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

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    // Simulate API login request
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;
    setState(() => _isLoading = false);

    AppToast.showSuccess(context, 'Welcome back to Watad!');
    context.go(AppRoutes.home);
  }

  void _handleForgetPassword() {
    context.push(AppRoutes.forgetPassScreen);
  }

  void _handleCreateAccount() {
    context.push(AppRoutes.signUpScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
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
                isLoading: _isLoading,
                onRememberMeChanged: (val) {
                  setState(() {
                    _rememberMe = val ?? false;
                  });
                },
                onForgetPasswordPressed: _handleForgetPassword,
                onLoginPressed: _handleLogin,
              ),
              LoginFooterSection(
                onCreateAccountPressed: _handleCreateAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
