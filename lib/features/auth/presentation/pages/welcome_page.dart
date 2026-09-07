import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/services/social_auth_service.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/presentation/view/sections/welcome_actions_section.dart';
import 'package:watad/features/auth/presentation/view/sections/welcome_footer_section.dart';
import 'package:watad/features/auth/presentation/view/sections/welcome_header_section.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _isGoogleLoading = false;
  bool _isFacebookLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isGoogleLoading = true);

    try {
      final token = await sl<SocialAuthService>().signInWithGoogle();

      if (!mounted) return;
      setState(() => _isGoogleLoading = false);

      if (token != null) {
        context.push(
          AppRoutes.roleSelection,
          extra: {
            'provider': 'google',
            'token': token,
          },
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isGoogleLoading = false);
      AppToast.showError(context, 'Google Sign-In failed: $e');
    }
  }

  Future<void> _handleFacebookSignIn() async {
    setState(() => _isFacebookLoading = true);

    try {
      final token = await sl<SocialAuthService>().signInWithFacebook();

      if (!mounted) return;
      setState(() => _isFacebookLoading = false);

      if (token != null) {
        context.push(
          AppRoutes.roleSelection,
          extra: {
            'provider': 'facebook',
            'token': token,
          },
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _isFacebookLoading = false);
      AppToast.showError(context, 'Facebook Sign-In failed: $e');
    }
  }

  void _handleEmailSignUp() {
    context.push(AppRoutes.signUpScreen);
  }

  void _handleLogin() {
    context.push(AppRoutes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.signUp,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const WelcomeHeaderSection(),
                  WelcomeActionsSection(
                    isGoogleLoading: _isGoogleLoading,
                    isFacebookLoading: _isFacebookLoading,
                    onGooglePressed: _handleGoogleSignIn,
                    onFacebookPressed: _handleFacebookSignIn,
                    onEmailPressed: _handleEmailSignUp,
                  ),
                  WelcomeFooterSection(
                    onLoginPressed: _handleLogin,
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
