import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/features/dashboard/owner/main_layout/presentation/view/main_layout.dart';
import 'package:watad/features/onboarding/presentation/pages/on_boarding_page.dart';
import 'package:watad/features/splash/presentation/pages/splash_page.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'package:watad/features/dashboard/owner/feasibility/presentation/view/feasibility_calculator_view.dart';
import 'package:watad/features/dashboard/owner/feasibility/presentation/view/feasibility_report_view.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/view/create_project_view.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.projectDashboard,
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
      path: AppRoutes.projectDashboard,
      builder: (context, state) => const MainLayout(),
    ),
    GoRoute(
      path: AppRoutes.feasibilityCalculator,
      builder: (context, state) => const FeasibilityCalculatorView(),
    ),
    GoRoute(
      path: AppRoutes.feasibilityReport,
      builder: (context, state) {
        final report = state.extra as FeasibilityReport;
        return FeasibilityReportView(report: report);
      },
    ),
    GoRoute(
      path: AppRoutes.createProject,
      builder: (context, state) => const CreateProjectView(),
    ),
  ],
);


