import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
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

    // Simulate Google Sign In token retrieval
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    setState(() => _isGoogleLoading = false);

    // Pass token & provider to Role Selection screen
    context.push(
      AppRoutes.roleSelection,
      extra: {
        'provider': 'google',
        'token': 'mock_google_id_token_watad_2026',
      },
    );
  }

  Future<void> _handleFacebookSignIn() async {
    setState(() => _isFacebookLoading = true);

    // Simulate Facebook Login token retrieval
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;
    setState(() => _isFacebookLoading = false);

    // Pass token & provider to Role Selection screen
    context.push(
      AppRoutes.roleSelection,
      extra: {
        'provider': 'facebook',
        'token': 'mock_facebook_access_token_watad_2026',
      },
    );
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
      backgroundColor: const Color(0xFFF6F8FA),
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
