import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
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
  ],
);


