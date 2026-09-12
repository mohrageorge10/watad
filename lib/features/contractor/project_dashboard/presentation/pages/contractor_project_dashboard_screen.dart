import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/cubit/contractor_project_dashboard_cubit.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/cubit/contractor_project_dashboard_state.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/view/sections/project_dashboard_active_milestone_card_section.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/view/sections/project_dashboard_daily_logs_section.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/view/sections/project_dashboard_hero_card_section.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/view/sections/project_dashboard_progress_card_section.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/view/sections/project_dashboard_shimmer_section.dart';

class ContractorProjectDashboardScreen extends StatelessWidget {
  final String projectId;
  final VoidCallback? onBackTap;

  const ContractorProjectDashboardScreen({
    super.key,
    required this.projectId,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContractorProjectDashboardCubit>()
        ..loadDashboard(projectId),
      child: _ContractorProjectDashboardView(
        projectId: projectId,
        onBackTap: onBackTap,
      ),
    );
  }
}

class _ContractorProjectDashboardView extends StatelessWidget {
  final String projectId;
  final VoidCallback? onBackTap;

  const _ContractorProjectDashboardView({
    required this.projectId,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A), // Dark Blue Header
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20.r,
          ),
          onPressed: onBackTap ??
              () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go(AppRoutes.home);
                }
              },
        ),
        title: Text(
          'Project Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        // NOTE: Gear/settings icon explicitly removed as requested by user
        actions: const [],
      ),
      body: BlocBuilder<ContractorProjectDashboardCubit,
          ContractorProjectDashboardState>(
        builder: (context, state) {
          if (state is ContractorProjectDashboardLoading ||
              state is ContractorProjectDashboardInitial) {
            return const ProjectDashboardShimmerSection();
          }

          if (state is ContractorProjectDashboardError) {
            return AppEmptyStateWidget(
              title: 'Error Loading Dashboard',
              message: state.message,
              buttonTitle: 'Try Again',
              onButtonPressed: () {
                context
                    .read<ContractorProjectDashboardCubit>()
                    .loadDashboard(projectId);
              },
            );
          }

          if (state is ContractorProjectDashboardSuccess) {
            final dashboard = state.dashboard;

            return RefreshIndicator(
              color: const Color(0xFF1E3A8A),
              onRefresh: () async {
                await context
                    .read<ContractorProjectDashboardCubit>()
                    .loadDashboard(projectId);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Hero Project Card
                    ProjectDashboardHeroCardSection(
                      dashboard: dashboard,
                    ),

                    SizedBox(height: 16.h),

                    // 2. Overall Progress Card
                    ProjectDashboardProgressCardSection(
                      overallProgress: dashboard.overallProgress,
                      completedProgress: dashboard.completedProgress,
                      inProgressProgress: dashboard.inProgressProgress,
                      notStartedProgress: dashboard.notStartedProgress,
                    ),

                    SizedBox(height: 16.h),

                    // 3. Active Milestone Card
                    ProjectDashboardActiveMilestoneCardSection(
                      milestone: dashboard.activeMilestone,
                    ),

                    SizedBox(height: 16.h),

                    // 4. Daily Logs Section
                    ProjectDashboardDailyLogsSection(
                      dailyLogs: dashboard.dailyLogs,
                      onViewAllTap: () {
                        context.pushNamed(
                          AppRoutes.contractorMilestoneLogs,
                          extra: {
                            'projectId': dashboard.projectId,
                          },
                        );
                      },
                      onAddLogTap: () {
                        context.pushNamed(
                          AppRoutes.contractorAddDailyLog,
                          extra: {
                            'projectId': dashboard.projectId,
                            'projectName': dashboard.title,
                            'milestoneName': dashboard.activeMilestone.title,
                            'location': dashboard.location,
                          },
                        );
                      },
                      onLogTap: (log) {
                        AppToast.showSuccess(
                          context,
                          'AI Verification: Verified',
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
