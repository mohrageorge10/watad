import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_overview_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_overview_state.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_projects_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_projects_state.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_profile_cubit.dart';
import 'package:watad/features/dashboard/owner/home/data/mock/home_mock_data.dart';
import '../sections/owner_home_header_section.dart';
import '../sections/active_project_card_section.dart';
import '../sections/smart_feasibility_banner_section.dart';
import '../sections/explore_services_section.dart';
import '../sections/my_projects_list_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HomeProfileCubit>()..fetchProfile()),
        BlocProvider(create: (_) => sl<HomeOverviewCubit>()..fetchOverview()),
        BlocProvider(create: (_) => sl<HomeProjectsCubit>()..loadFirstPage()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.secondBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 24.h, bottom: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OwnerHomeHeaderSection(),
                SizedBox(height: 24.h),
                BlocBuilder<HomeOverviewCubit, HomeOverviewState>(
                  builder: (context, state) {
                    if (state is HomeOverviewLoading) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                      );
                    } else if (state is HomeOverviewLoaded) {
                      return ActiveProjectCardSection(project: state.data);
                    } else if (state is HomeOverviewEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: AppColors.white100,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: AppColors.signUp),
                          ),
                          child: Center(
                            child: Text(
                              "No Active Project. Start one!",
                              style: AppTextStyles.font14SemiBoldDark,
                            ),
                          ),
                        ),
                      );
                    } else if (state is HomeOverviewError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(height: 24.h),
                const SmartFeasibilityBannerSection(),
                SizedBox(height: 24.h),
                const ExploreServicesSection(services: HomeMockData.services),
                SizedBox(height: 24.h),
                BlocBuilder<HomeProjectsCubit, HomeProjectsState>(
                  builder: (context, state) {
                    if (state.status == HomeProjectsStatus.loading) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                    } else if (state.status == HomeProjectsStatus.success) {
                      return MyProjectsListSection(projects: state.items);
                    } else if (state.status == HomeProjectsStatus.empty) {
                      return const Center(child: Text("No projects found", style: AppTextStyles.font14Medium));
                    } else if (state.status == HomeProjectsStatus.failure) {
                      return Center(child: Text(state.errorMessage ?? "Error"));
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
