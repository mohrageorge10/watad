import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/features/auth/data/models/role_model.dart';
import 'package:watad/features/auth/presentation/pages/forget_password_page.dart';
import 'package:watad/features/auth/presentation/pages/login_page.dart';
import 'package:watad/features/auth/presentation/pages/otp_page.dart';
import 'package:watad/features/auth/presentation/pages/reset_password_page.dart';
import 'package:watad/features/auth/presentation/pages/role_selection_page.dart';
import 'package:watad/features/auth/presentation/pages/sign_up_email_confirmation_page.dart';
import 'package:watad/features/auth/presentation/pages/sign_up_password_page.dart';
import 'package:watad/features/auth/presentation/pages/sign_up_personal_info_page.dart';
import 'package:watad/features/auth/presentation/pages/sign_up_role_page.dart';
import 'package:watad/features/auth/presentation/pages/welcome_page.dart';
import 'package:watad/features/contractor/home/presentation/pages/home_gate_screen.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';
import 'package:watad/features/contractor/profile/presentation/pages/contractor_profile_page.dart';
import 'package:watad/features/contractor/profile/presentation/pages/edit_profile_page.dart';
import 'package:watad/features/contractor/portfolio/presentation/pages/portfolio_projects_screen.dart';
import 'package:watad/features/onboarding/presentation/pages/on_boarding_page.dart';
import 'package:watad/features/splash/presentation/pages/splash_page.dart';

CustomTransitionPage<void> _buildAnimatedPage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      );
      return FadeTransition(
        opacity: curvedAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.08, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        ),
      );
    },
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  observers: [FlutterSmartDialog.observer],
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const HomeGateScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.onBoarding,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const OnBoardingPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const WelcomePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.roleSelection,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return _buildAnimatedPage(
          state: state,
          child: RoleSelectionPage(
            authProvider: extra?['provider'] as String?,
            authToken: extra?['token'] as String?,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.loginScreen,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.forgetPassScreen,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const ForgetPasswordPage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.otpScreen,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return _buildAnimatedPage(
          state: state,
          child: OtpPage(
            email: extra?['email'] as String?,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.resetPasswordScreen,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return _buildAnimatedPage(
          state: state,
          child: ResetPasswordPage(
            email: extra?['email'] as String?,
            otp: extra?['otp'] as String?,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.signUpScreen,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const SignUpRolePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.signUpPersonalInfo,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return _buildAnimatedPage(
          state: state,
          child: SignUpPersonalInfoPage(
            role: extra?['role'] as RoleModel?,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.signUpPassword,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return _buildAnimatedPage(
          state: state,
          child: SignUpPasswordPage(
            role: extra?['role'] as RoleModel?,
            email: extra?['email'] as String?,
            fullName: extra?['fullName'] as String?,
            phone: extra?['phone'] as String?,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.signUpConfirmation,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return _buildAnimatedPage(
          state: state,
          child: SignUpEmailConfirmationPage(
            role: extra?['role'] as RoleModel?,
            email: extra?['email'] as String?,
            fullName: extra?['fullName'] as String?,
            phone: extra?['phone'] as String?,
            password: extra?['password'] as String?,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.contractorProfile,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const ContractorProfilePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.editProfile,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: EditProfilePage(
          cubit: state.extra as ContractorProfileCubit?,
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.portfolioProjects,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const PortfolioProjectsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.myProjects,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const PortfolioProjectsScreen(),
      ),
    ),
  ],
);
