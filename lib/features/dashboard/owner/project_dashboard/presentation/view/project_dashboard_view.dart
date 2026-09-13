import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import '../cubit/project_dashboard_cubit.dart';
import '../cubit/project_dashboard_state.dart';
import '../widgets/dashboard_shimmer.dart';
import '../widgets/milestones_section.dart';
import '../widgets/progress_card_section.dart';
import '../widgets/quick_access_section.dart';

class ProjectDashboardView extends StatelessWidget {
  final String? projectId;

  const ProjectDashboardView({super.key, this.projectId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProjectDashboardCubit>()
        ..fetchDashboardData(projectId),
      child: const ProjectDashboardBody(),
    );
  }
}

class ProjectDashboardBody extends StatelessWidget {
  const ProjectDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      body: SafeArea(
        child: BlocConsumer<ProjectDashboardCubit, ProjectDashboardState>(
          listener: (context, state) {
            if (state is ProjectDashboardError) {
              AppToast.showError(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is ProjectDashboardLoading || state is ProjectDashboardInitial) {
              return const DashboardShimmer();
            } else if (state is ProjectDashboardEmpty) {
              return const AppEmptyStateWidget(
                title: 'No Active Project',
                message: 'No active project found to display its dashboard.',
              );
            } else if (state is ProjectDashboardError) {
              return AppEmptyStateWidget(
                title: 'Failed to load dashboard',
                message: state.message,
                buttonTitle: 'Retry',
                onButtonPressed: () {
                  context.read<ProjectDashboardCubit>().fetchDashboardData();
                },
              );
            } else if (state is ProjectDashboardLoaded) {
              final data = state.data;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Custom App Bar (Unchanged)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.white100,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 16.w,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).maybePop(),
                              child: Icon(
                                Icons.arrow_back,
                                color: AppColors.primary,
                                size: 24.sp,
                              ),
                            ),
                          ),
                          Text(
                            data.projectName,
                            style: AppTextStyles.font14SemiBoldDark.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Dynamic Blue Container (Uses existing ProgressCardSection UI)
                    ProgressCardSection(progress: data.progress),
                    SizedBox(height: 24.h),

                    // Static 4 Quick Access Cards (Unchanged)
                    QuickAccessSection(items: data.quickAccessItems),
                    SizedBox(height: 24.h),

                    // Dynamic Milestones List
                    MilestonesSection(milestones: data.milestones),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}