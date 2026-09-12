import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/theme/app_colors.dart';
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
import 'package:watad/features/dashboard/owner/alerts/presentation/view/alerts_view.dart';
import 'package:watad/features/dashboard/owner/copilot/presentation/view/copilot_chat_view.dart';
import 'package:watad/features/dashboard/owner/home/presentation/view/future_plan_view.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/view/bid_details_view.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/view/bid_result_view.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/view/create_contract_view.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/view/milestones_form_view.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/view/contract_details_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/financial_summary/presentation/view/financial_summary_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/progress_site_updates/presentation/view/progress_site_updates_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/all_change_orders_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/change_orders_view.dart';
<<<<<<< HEAD
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/domain/entities/change_order_details.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/change_order_details_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/confirm_accept_change_order_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/confirm_reject_change_order_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/change_order_accepted_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/create_change_order_view.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/presentation/view/change_order_submitted_view.dart';
=======

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

>>>>>>> origin/develop
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  observers: [FlutterSmartDialog.observer],
  errorPageBuilder: (context, state) => _buildAnimatedPage(
    state: state,
    child: Scaffold(
      backgroundColor: AppColors.secondBackground,
      appBar: AppBar(
        title: const Text('Page Not Found'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.home);
            }
          },
        ),
      ),
      body: AppEmptyStateWidget(
        title: 'Page Not Found',
        message:
            'The requested route "${state.uri.toString()}" does not exist.',
        buttonTitle: 'Go Home',
        onButtonPressed: () => context.go(AppRoutes.home),
      ),
    ),
  ),
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      name: AppRoutes.splash,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const SplashPage()),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: AppRoutes.home,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const HomeGateScreen()),
    ),
    GoRoute(
      path: AppRoutes.onBoarding,
      name: AppRoutes.onBoarding,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const OnBoardingPage()),
    ),
    GoRoute(
      path: AppRoutes.projectDashboard,
      name: AppRoutes.projectDashboard,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const MainLayout()),
    ),
    GoRoute(
      path: AppRoutes.financialSummary,
      name: AppRoutes.financialSummary,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const FinancialSummaryView()),
    ),
    GoRoute(
      path: AppRoutes.progressSiteUpdates,
      name: AppRoutes.progressSiteUpdates,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const ProgressSiteUpdatesView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.changeOrders,
      name: AppRoutes.changeOrders,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const ChangeOrdersView()),
    ),
    GoRoute(
      path: AppRoutes.allChangeOrders,
      builder: (context, state) => const AllChangeOrdersView(),
    ),
    GoRoute(
      path: AppRoutes.changeOrderDetails,
      builder: (context, state) {
        if (state.extra is Map<String, dynamic>) {
          final map = state.extra as Map<String, dynamic>;
          return ChangeOrderDetailsView(
            orderId: map['id'] as String,
            isPending: map['isPending'] as bool? ?? false,
          );
        } else {
          final orderId = state.extra as String;
          return ChangeOrderDetailsView(orderId: orderId, isPending: false);
        }
      },
    ),
    GoRoute(
      path: AppRoutes.confirmAcceptChangeOrder,
      builder: (context, state) {
        final order = state.extra as ChangeOrderDetails;
        return ConfirmAcceptChangeOrderView(order: order);
      },
    ),
    GoRoute(
      path: AppRoutes.confirmRejectChangeOrder,
      builder: (context, state) {
        final order = state.extra as ChangeOrderDetails;
        return ConfirmRejectChangeOrderView(order: order);
      },
    ),
    GoRoute(
      path: AppRoutes.changeOrderAccepted,
      builder: (context, state) {
        final order = state.extra as ChangeOrderDetails;
        return ChangeOrderAcceptedView(order: order);
      },
    ),
    GoRoute(
      path: AppRoutes.createChangeOrder,
      builder: (context, state) => const CreateChangeOrderView(),
    ),
    GoRoute(
      path: AppRoutes.changeOrderSubmitted,
      builder: (context, state) {
        final orderId = state.extra as String;
        return ChangeOrderSubmittedView(orderId: orderId);
      },
    ),
    GoRoute(
      path: AppRoutes.feasibilityCalculator,
      name: AppRoutes.feasibilityCalculator,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const FeasibilityCalculatorView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.feasibilityReport,
      name: AppRoutes.feasibilityReport,
      pageBuilder: (context, state) {
        if (state.extra is FeasibilityReport) {
          final report = state.extra as FeasibilityReport;
          return _buildAnimatedPage(
            state: state,
            child: FeasibilityReportView(report: report),
          );
        }
        return _buildAnimatedPage(
          state: state,
          child: Scaffold(
            appBar: AppBar(title: const Text('Feasibility Report')),
            body: AppEmptyStateWidget(
              title: 'No Report Data',
              message: 'Unable to load feasibility report details.',
              buttonTitle: 'Back to Calculator',
              onButtonPressed: () =>
                  context.go(AppRoutes.feasibilityCalculator),
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.createProject,
      name: AppRoutes.createProject,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const CreateProjectView()),
    ),
    GoRoute(
<<<<<<< HEAD
      path: AppRoutes.futurePlan,
      builder: (context, state) => const FuturePlanView(),
    ),
    GoRoute(
      name: 'bid_details',
      path: AppRoutes.bidDetails,
      builder: (context, state) {
        final bidId = state.extra as String;
        return BidDetailsView(bidId: bidId);
=======
      path: AppRoutes.ownerBidDetails,
      name: AppRoutes.ownerBidDetails,
      pageBuilder: (context, state) {
        String bidId = '';
        if (state.extra is String) {
          bidId = state.extra as String;
        } else if (state.extra is Map<String, dynamic>) {
          bidId =
              (state.extra as Map<String, dynamic>)['bidId'] as String? ?? '';
        }
        return _buildAnimatedPage(
          state: state,
          child: BidDetailsView(bidId: bidId),
        );
>>>>>>> origin/develop
      },
    ),
    GoRoute(
      path: AppRoutes.bidResult,
      name: AppRoutes.bidResult,
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        final isAccepted = args['isAccepted'] as bool? ?? false;
        final bidId = args['bidId'] as String? ?? '';
        return _buildAnimatedPage(
          state: state,
          child: BidResultView(
            isAccepted: isAccepted,
            bidId: bidId,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.createContractForm,
      name: AppRoutes.createContractForm,
      pageBuilder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        final bidId = args['bidId'] as String? ?? '';
        return _buildAnimatedPage(
          state: state,
          child: CreateContractView(
            bidId: bidId,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.milestonesForm,
      name: AppRoutes.milestonesForm,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const MilestonesFormView()),
    ),
    GoRoute(
      path: AppRoutes.ownerContractDetails,
      name: AppRoutes.ownerContractDetails,
      pageBuilder: (context, state) {
        String contractId = '';
        if (state.extra is String) {
          contractId = state.extra as String;
        } else if (state.extra is Map<String, dynamic>) {
          contractId =
              (state.extra as Map<String, dynamic>)['contractId'] as String? ??
                  '';
        }
        return _buildAnimatedPage(
          state: state,
          child: ContractDetailsView(contractId: contractId),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.welcome,
      name: AppRoutes.welcome,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const WelcomePage()),
    ),
    GoRoute(
      path: AppRoutes.roleSelection,
      name: AppRoutes.roleSelection,
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
      name: AppRoutes.loginScreen,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const LoginPage()),
    ),
    GoRoute(
      path: AppRoutes.forgetPassScreen,
      name: AppRoutes.forgetPassScreen,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const ForgetPasswordPage()),
    ),
    GoRoute(
      path: AppRoutes.otpScreen,
      name: AppRoutes.otpScreen,
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
      name: AppRoutes.resetPasswordScreen,
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
      name: AppRoutes.signUpScreen,
      pageBuilder: (context, state) =>
          _buildAnimatedPage(state: state, child: const SignUpRolePage()),
    ),
    GoRoute(
      path: AppRoutes.signUpPersonalInfo,
      name: AppRoutes.signUpPersonalInfo,
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
      name: AppRoutes.signUpPassword,
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
      name: AppRoutes.signUpConfirmation,
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
      name: AppRoutes.contractorProfile,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const ContractorProfilePage(),
      ),
    ),
    GoRoute(
      path: AppRoutes.editProfile,
      name: AppRoutes.editProfile,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: EditProfilePage(cubit: state.extra as ContractorProfileCubit?),
      ),
    ),
    GoRoute(
      path: AppRoutes.portfolioProjects,
      name: AppRoutes.portfolioProjects,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const PortfolioProjectsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.myProjects,
      name: AppRoutes.myProjects,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const PortfolioProjectsScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.contractorBids,
      name: AppRoutes.contractorBids,
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
      name: AppRoutes.marketplace,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: const MarketplaceScreen(showBottomNavBar: true),
      ),
    ),
    GoRoute(
      path: AppRoutes.addPortfolioProject,
      name: AppRoutes.addPortfolioProject,
      pageBuilder: (context, state) => _buildAnimatedPage(
        state: state,
        child: AddPortfolioProjectScreen(
          project: state.extra as PortfolioProjectItemModel?,
        ),
      ),
    ),
    GoRoute(
      path: AppRoutes.portfolioProjectDetails,
      name: AppRoutes.portfolioProjectDetails,
      pageBuilder: (context, state) {
        if (state.extra is PortfolioProjectItemModel) {
          return _buildAnimatedPage(
            state: state,
            child: PortfolioProjectDetailsScreen(
              project: state.extra as PortfolioProjectItemModel,
            ),
          );
        }
        return _buildAnimatedPage(
          state: state,
          child: Scaffold(
            backgroundColor: AppColors.secondBackground,
            appBar: AppBar(
              title: const Text('Project Details'),
              centerTitle: true,
            ),
            body: AppEmptyStateWidget(
              title: 'Project Not Found',
              message: 'No project data provided.',
              buttonTitle: 'Back to Portfolio',
              onButtonPressed: () => context.go(AppRoutes.portfolioProjects),
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.marketplaceProjectDetails,
      name: AppRoutes.marketplaceProjectDetails,
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
      name: AppRoutes.submitBid,
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
    GoRoute(
      path: AppRoutes.copilot,
      builder: (context, state) => const CopilotChatView(),
    ),
  ],
);
