import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/presentation/view/sections/welcome_actions_section.dart';
import 'package:watad/features/auth/presentation/view/sections/welcome_footer_section.dart';
import 'package:watad/features/auth/presentation/view/sections/welcome_header_section.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  void _handleSignUp(BuildContext context) {
    context.push(AppRoutes.signUpScreen);
  }

  void _handleLogin(BuildContext context) {
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
                    onSignUpPressed: () => _handleSignUp(context),
                  ),
                  WelcomeFooterSection(
                    onLoginPressed: () => _handleLogin(context),
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
