import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
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
import 'package:watad/features/contractor/home/presentation/pages/home_gate_screen.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';
import 'package:watad/features/contractor/profile/presentation/pages/contractor_profile_page.dart';
import 'package:watad/features/contractor/profile/presentation/pages/edit_profile_page.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/presentation/pages/add_portfolio_project_screen.dart';
import 'package:watad/features/contractor/portfolio/presentation/pages/portfolio_project_details_screen.dart';
import 'package:watad/features/contractor/portfolio/presentation/pages/portfolio_projects_screen.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/bids/presentation/pages/bid_details_screen.dart';
import 'package:watad/features/contractor/bids/presentation/pages/contractor_bids_screen.dart';
import 'package:watad/features/contractor/bids/presentation/pages/edit_bid_screen.dart';
import 'package:watad/features/contractor/bids/presentation/pages/my_bids_management_screen.dart';
import 'package:watad/features/contractor/marketplace/data/mock/mock_marketplace_details_data.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_details_entity.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';
import 'package:watad/features/contractor/marketplace/presentation/pages/marketplace_project_details_screen.dart';
import 'package:watad/features/contractor/marketplace/presentation/pages/marketplace_screen.dart';
import 'package:watad/features/contractor/marketplace/presentation/pages/submit_bid_screen.dart';
import 'package:watad/features/contractor/contracts/presentation/pages/contract_details_sign_screen.dart';
import 'package:watad/features/contractor/contracts/presentation/pages/contract_preview_screen.dart';
import 'package:watad/features/contractor/contracts/domain/entities/contract_entity.dart';
import 'package:watad/features/onboarding/presentation/pages/on_boarding_page.dart';
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
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/change_orders_view.dart';

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
  initialLocation: AppRoutes.projectDashboard,
  observers: [FlutterSmartDialog.observer],
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const SplashPage()),
    ),
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const HomeGateScreen()),
    ),
    GoRoute(
      path: AppRoutes.onBoarding,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const OnBoardingPage()),
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
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const WelcomePage()),
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
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const LoginPage()),
    ),
    GoRoute(
      path: AppRoutes.forgetPassScreen,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const ForgetPasswordPage()),
    ),
    GoRoute(
      path: AppRoutes.otpScreen,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return _buildAnimatedPage(
          state: state,
          child: OtpPage(email: extra?['email'] as String?),
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
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const SignUpRolePage()),
    ),
    GoRoute(
      path: AppRoutes.signUpPersonalInfo,
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return _buildAnimatedPage(
          state: state,
          child: SignUpPersonalInfoPage(role: extra?['role'] as RoleModel?),
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
        child: EditProfilePage(cubit: state.extra as ContractorProfileCubit?),
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
    GoRoute(
      path: AppRoutes.contractorBids,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const ContractorBidsScreen(showBackButton: true),
      ),
    ),
    GoRoute(
      path: AppRoutes.myBids,
      name: AppRoutes.myBids,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const MyBidsManagementScreen(showBottomNavBar: true),
      ),
    ),
    GoRoute(
      path: AppRoutes.marketplace,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const MarketplaceScreen(showBottomNavBar: true),
      ),
    ),
    GoRoute(
      path: AppRoutes.addPortfolioProject,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: AddPortfolioProjectScreen(
          project: state.extra as PortfolioProjectItemModel?,
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.portfolioProjectDetails,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: PortfolioProjectDetailsScreen(
          project: state.extra as PortfolioProjectItemModel,
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.marketplaceProjectDetails,
      pageBuilder: (context, state) {
        MarketplaceProjectDetailsEntity? details;
        if (state.extra is MarketplaceProjectDetailsEntity) {
          details = state.extra as MarketplaceProjectDetailsEntity;
        } else if (state.extra is MarketplaceProjectEntity) {
          details = MockMarketplaceDetailsData.getDetailsForProject(
            state.extra as MarketplaceProjectEntity,
          );
        }

        return _buildAnimatedPage(
          state: state,
          child: MarketplaceProjectDetailsScreen(project: details),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.submitBid,
      pageBuilder: (context, state) {
        String projectName = 'Villa Construction Project - New Cairo';
        String initialCost = '2,450,000';
        String initialDuration = '6';

        if (state.extra is MarketplaceProjectDetailsEntity) {
          final p = state.extra as MarketplaceProjectDetailsEntity;
          projectName = '${p.title} - ${p.location}';
          final costDigits = p.estimatedBudget
              .replaceAll(RegExp(r'[^0-9,]'), '')
              .trim();
          if (costDigits.isNotEmpty) initialCost = costDigits;
          final durDigits = p.expectedDuration
              .replaceAll(RegExp(r'[^0-9]'), '')
              .trim();
          if (durDigits.isNotEmpty) initialDuration = durDigits;
        } else if (state.extra is Map<String, dynamic>) {
          final map = state.extra as Map<String, dynamic>;
          projectName = map['projectName'] as String? ?? projectName;
          initialCost = map['initialCost'] as String? ?? initialCost;
          initialDuration =
              map['initialDuration'] as String? ?? initialDuration;
        }

        return _buildAnimatedPage(
          state: state,
          child: SubmitBidScreen(
            projectName: projectName,
            initialCost: initialCost,
            initialDuration: initialDuration,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.editBid,
      name: AppRoutes.editBid,
      pageBuilder: (context, state) {
        String bidId = '';
        String projectName = 'Villa Construction Project - New Cairo';
        String initialCost = '2,450,000';
        String initialDuration = '6';

        if (state.extra is MyBidEntity) {
          final b = state.extra as MyBidEntity;
          bidId = b.id;
          projectName = b.title;
          final costDigits = b.yourBid
              .replaceAll(RegExp(r'[^0-9,]'), '')
              .trim();
          if (costDigits.isNotEmpty) initialCost = costDigits;
          final durDigits = b.duration.replaceAll(RegExp(r'[^0-9]'), '').trim();
          if (durDigits.isNotEmpty) initialDuration = durDigits;
        } else if (state.extra is Map<String, dynamic>) {
          final map = state.extra as Map<String, dynamic>;
          bidId = map['bidId'] as String? ?? bidId;
          projectName = map['projectName'] as String? ?? projectName;
          initialCost = map['initialCost'] as String? ?? initialCost;
          initialDuration =
              map['initialDuration'] as String? ?? initialDuration;
        }

        return _buildAnimatedPage(
          state: state,
          child: EditBidScreen(
            bidId: bidId,
            projectName: projectName,
            initialCost: initialCost,
            initialDuration: initialDuration,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.bidDetails,
      name: AppRoutes.bidDetails,
      pageBuilder: (context, state) {
        MyBidEntity? bid;
        if (state.extra is MyBidEntity) {
          bid = state.extra as MyBidEntity;
        }

        return _buildAnimatedPage(
          state: state,
          child: BidDetailsScreen(bid: bid),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.contractDetails,
      name: AppRoutes.contractDetails,
      pageBuilder: (context, state) {
        String? contractId;
        String? bidId;
        ContractEntity? initialContract;
        if (state.extra is String) {
          contractId = state.extra as String;
        } else if (state.extra is ContractEntity) {
          initialContract = state.extra as ContractEntity;
          contractId = initialContract.id;
        } else if (state.extra is Map<String, dynamic>) {
          final map = state.extra as Map<String, dynamic>;
          contractId = map['contractId'] as String?;
          bidId = map['bidId'] as String?;
          if (map['contract'] is ContractEntity) {
            initialContract = map['contract'] as ContractEntity;
          }
        }

        return _buildAnimatedPage(
          state: state,
          child: ContractDetailsSignScreen(
            contractId: contractId,
            bidId: bidId,
            initialContract: initialContract,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.contractPreview,
      name: AppRoutes.contractPreview,
      pageBuilder: (context, state) {
        String? contractId;
        ContractEntity? initialContract;
        if (state.extra is String) {
          contractId = state.extra as String;
        } else if (state.extra is ContractEntity) {
          initialContract = state.extra as ContractEntity;
          contractId = initialContract.id;
        } else if (state.extra is Map<String, dynamic>) {
          final map = state.extra as Map<String, dynamic>;
          contractId = map['contractId'] as String?;
          if (map['contract'] is ContractEntity) {
            initialContract = map['contract'] as ContractEntity;
          }
        }

        return _buildAnimatedPage(
          state: state,
          child: ContractPreviewScreen(
            contractId: contractId,
            initialContract: initialContract,
          ),
        );
      },
    ),
  ],
);
