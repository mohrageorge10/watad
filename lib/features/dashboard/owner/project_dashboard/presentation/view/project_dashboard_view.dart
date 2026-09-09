import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../data/repositories/mock_project_dashboard_repository.dart';
import '../cubit/project_dashboard_cubit.dart';
import '../cubit/project_dashboard_state.dart';
import '../widgets/progress_card_section.dart';
import '../widgets/quick_access_section.dart';
import '../widgets/activity_feed_section.dart';

class ProjectDashboardView extends StatelessWidget {
  const ProjectDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProjectDashboardCubit(MockProjectDashboardRepository())
        ..fetchDashboardData('mock_project_id'),
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
        child: BlocBuilder<ProjectDashboardCubit, ProjectDashboardState>(
          builder: (context, state) {
            if (state is ProjectDashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProjectDashboardError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ProjectDashboardLoaded) {
              final data = state.data;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Custom App Bar
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.white100,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
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
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.primary,
                              size: 24.sp,
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
                    
                    ProgressCardSection(progress: data.progress),
                    SizedBox(height: 24.h),
                    
                    QuickAccessSection(items: data.quickAccessItems),
                    SizedBox(height: 24.h),
                    
                    ActivityFeedSection(items: data.activityFeed),
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
