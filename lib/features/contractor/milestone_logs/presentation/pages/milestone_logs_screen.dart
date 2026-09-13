import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/milestone_logs/presentation/cubit/milestone_logs_cubit.dart';
import 'package:watad/features/contractor/milestone_logs/presentation/cubit/milestone_logs_state.dart';
import 'package:watad/features/contractor/milestone_logs/presentation/view/sections/milestone_logs_filter_chips_section.dart';
import 'package:watad/features/contractor/milestone_logs/presentation/view/sections/milestone_logs_project_header_section.dart';
import 'package:watad/features/contractor/milestone_logs/presentation/view/sections/milestone_logs_shimmer_section.dart';
import 'package:watad/features/contractor/milestone_logs/presentation/view/sections/milestone_logs_timeline_section.dart';

class MilestoneLogsScreen extends StatelessWidget {
  final String? projectId;
  final VoidCallback? onBackTap;

  const MilestoneLogsScreen({
    super.key,
    this.projectId,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MilestoneLogsCubit>()
        ..loadMilestoneLogs(projectId ?? 'proj_1'),
      child: _MilestoneLogsView(
        projectId: projectId ?? 'proj_1',
        onBackTap: onBackTap,
      ),
    );
  }
}

class _MilestoneLogsView extends StatelessWidget {
  final String projectId;
  final VoidCallback? onBackTap;

  const _MilestoneLogsView({
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
                  context.go(AppRoutes.contractorProjectDashboard);
                }
              },
        ),
        title: Text(
          'Milestone Logs & Inspection',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<MilestoneLogsCubit, MilestoneLogsState>(
        listener: (context, state) {
          if (state is MilestoneLogsSuccess) {
            if (state.isInspectionRequestedSuccess &&
                state.inspectionMessage != null) {
              AppToast.showSuccess(context, state.inspectionMessage!);
            }
          }
          if (state is MilestoneLogsError) {
            AppToast.showError(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is MilestoneLogsLoading || state is MilestoneLogsInitial) {
            return const MilestoneLogsShimmerSection();
          }

          if (state is MilestoneLogsError) {
            return AppEmptyStateWidget(
              title: 'Error Loading Logs',
              message: state.message,
              buttonTitle: 'Try Again',
              onButtonPressed: () {
                context
                    .read<MilestoneLogsCubit>()
                    .loadMilestoneLogs(projectId);
              },
            );
          }

          if (state is MilestoneLogsSuccess) {
            return RefreshIndicator(
              color: const Color(0xFF1E3A8A),
              onRefresh: () async {
                await context
                    .read<MilestoneLogsCubit>()
                    .loadMilestoneLogs(projectId);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Project Header Section
                    MilestoneLogsProjectHeaderSection(
                      header: state.header,
                    ),

                    SizedBox(height: 16.h),

                    // 2. Filter Chips Section
                    MilestoneLogsFilterChipsSection(
                      selectedFilter: state.selectedFilter,
                      dailyLogsCount: state.dailyLogsCount,
                      qaqcCount: state.qaqcCount,
                      safetyCount: state.safetyCount,
                      onFilterSelected: (type) {
                        context.read<MilestoneLogsCubit>().setFilter(type);
                      },
                    ),

                    SizedBox(height: 16.h),

                    // 3. Timeline Feed Section
                    MilestoneLogsTimelineSection(
                      logs: state.filteredLogs,
                    ),

                    SizedBox(height: 16.h),

                    // 4. Action Button
                    AppElevatedButton(
                      title:
                          'Request Milestone Inspection / Submit for Review',
                      height: 52,
                      borderRadius: 14,
                      backgroundColor: const Color(0xFF1E3A8A),
                      isLoading: state.isRequestingInspection,
                      onPressed: () {
                        context.pushNamed(
                          AppRoutes.contractorMilestoneInspection,
                          extra: {
                            'milestoneId': 'ms_101',
                            'projectId': projectId,
                          },
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
