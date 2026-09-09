import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_overview_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_projects_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_profile_cubit.dart';
import 'package:watad/features/dashboard/owner/home/data/mock/home_mock_data.dart';
import '../sections/owner_home_header_section.dart';
import '../sections/home_overview_section.dart';
import '../sections/smart_feasibility_banner_section.dart';
import '../sections/explore_services_section.dart';
import '../sections/home_projects_section.dart';

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
                const HomeOverviewSection(),
                SizedBox(height: 24.h),
                const SmartFeasibilityBannerSection(),
                SizedBox(height: 24.h),
                const ExploreServicesSection(services: HomeMockData.services),
                SizedBox(height: 24.h),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: HomeProjectsSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
