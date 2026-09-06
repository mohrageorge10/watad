import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/features/auth/presentation/pages/role_selection_page.dart';
import 'package:watad/features/auth/presentation/pages/welcome_page.dart';
import 'package:watad/features/onboarding/presentation/pages/on_boarding_page.dart';
import 'package:watad/features/splash/presentation/pages/splash_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.onBoarding,
      builder: (context, state) => const OnBoardingPage(),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: AppRoutes.roleSelection,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return RoleSelectionPage(
          authProvider: extra?['provider'] as String?,
          authToken: extra?['token'] as String?,
        );
      },
    ),
  ],
);


