import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/features/dashboard/owner/main_layout/presentation/view/main_layout.dart';
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
import 'package:watad/features/onboarding/presentation/pages/on_boarding_page.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:watad/features/splash/presentation/pages/splash_page.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'package:watad/features/dashboard/owner/feasibility/presentation/view/feasibility_calculator_view.dart';
import 'package:watad/features/dashboard/owner/feasibility/presentation/view/feasibility_report_view.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/view/create_project_view.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/view/bid_details_view.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/view/bid_result_view.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/view/create_contract_view.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/view/milestones_form_view.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/view/contract_details_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/financial_summary/presentation/view/financial_summary_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/progress_site_updates/presentation/view/progress_site_updates_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/all_change_orders_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/change_orders_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  observers: [FlutterSmartDialog.observer],
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
      path: AppRoutes.financialSummary,
      builder: (context, state) => const FinancialSummaryView(),
    ),
    GoRoute(
      path: AppRoutes.progressSiteUpdates,
      builder: (context, state) => const ProgressSiteUpdatesView(),
    ),
    GoRoute(
      path: AppRoutes.changeOrders,
      builder: (context, state) => const ChangeOrdersView(),
    ),
    GoRoute(
      path: AppRoutes.allChangeOrders,
      builder: (context, state) => const AllChangeOrdersView(),
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
    GoRoute(
      name: 'bid_details',
      path: AppRoutes.bidDetails,
      builder: (context, state) {
        final bidId = state.extra as String;
        return BidDetailsView(bidId: bidId);
      },
    ),
    GoRoute(
      name: 'bid_result',
      path: AppRoutes.bidResult,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        final isAccepted = args['isAccepted'] as bool? ?? false;
        final bidId = args['bidId'] as String? ?? '';
        return BidResultView(
          isAccepted: isAccepted,
          bidId: bidId, // We need to update BidResultView to accept bidId
        );
      },
    ),
    GoRoute(
      name: 'create_contract_form',
      path: AppRoutes.createContractForm,
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        return CreateContractView(
          bidId: args['bidId'] ?? '',
        );
      },
    ),
    GoRoute(
      name: 'milestones_form',
      path: AppRoutes.milestonesForm,
      builder: (context, state) => const MilestonesFormView(),
    ),
    GoRoute(
      name: 'contract_details',
      path: AppRoutes.contractDetails,
      builder: (context, state) {
        final contractId = state.extra as String;
        return ContractDetailsView(contractId: contractId);
      },
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
    GoRoute(
      path: AppRoutes.loginScreen,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.forgetPassScreen,
      builder: (context, state) => const ForgetPasswordPage(),
    ),
    GoRoute(
      path: AppRoutes.otpScreen,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return OtpPage(
          email: extra?['email'] as String?,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.resetPasswordScreen,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return ResetPasswordPage(
          email: extra?['email'] as String?,
          otp: extra?['otp'] as String?,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.signUpScreen,
      builder: (context, state) => const SignUpRolePage(),
    ),
    GoRoute(
      path: AppRoutes.signUpPersonalInfo,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return SignUpPersonalInfoPage(
          role: extra?['role'] as RoleModel?,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.signUpPassword,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return SignUpPasswordPage(
          role: extra?['role'] as RoleModel?,
          email: extra?['email'] as String?,
          fullName: extra?['fullName'] as String?,
          phone: extra?['phone'] as String?,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.signUpConfirmation,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return SignUpEmailConfirmationPage(
          role: extra?['role'] as RoleModel?,
          email: extra?['email'] as String?,
          fullName: extra?['fullName'] as String?,
          phone: extra?['phone'] as String?,
          password: extra?['password'] as String?,
        );
      },
    ),
  ],
);


