import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_state.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/about_me_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/company_info_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/contractor_profile_header_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/contractor_profile_shimmer_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/covered_governorates_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/custom_tab_bar_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/main_profile_card_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/portfolio_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/specialization_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/stats_card_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/contractor_profile_bottom_nav_bar.dart';

class ContractorProfileScreen extends StatelessWidget {
  final VoidCallback? onSettingsTap;
  final VoidCallback? onNavigateToMyProjects;
  final bool showBottomNavBar;

  const ContractorProfileScreen({
    super.key,
    this.onSettingsTap,
    this.onNavigateToMyProjects,
    this.showBottomNavBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: BlocBuilder<ContractorProfileCubit, ContractorProfileState>(
        builder: (context, state) {
          if (state is ContractorProfileLoading ||
              state is ContractorProfileInitial) {
            return const ContractorProfileShimmerSection();
          }

          if (state is ContractorProfileError) {
            return AppEmptyStateWidget(
              title: 'Failed to load profile',
              message: state.message,
              buttonTitle: 'Try Again',
              onButtonPressed: () {
                context.read<ContractorProfileCubit>().loadProfile();
              },
            );
          }

          if (state is ContractorProfileEmpty) {
            return AppEmptyStateWidget(
              title: 'No Profile Found',
              message: state.message,
              buttonTitle: 'Reload',
              onButtonPressed: () {
                context.read<ContractorProfileCubit>().loadProfile();
              },
            );
          }

          if (state is ContractorProfileSuccess) {
            final profile = state.profile;
            final selectedTab = state.selectedTabIndex;
            final cubit = context.read<ContractorProfileCubit>();

            return RefreshIndicator(
              onRefresh: () async {
                await cubit.loadProfile();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header & Overlapping Main Profile Card
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        ContractorProfileHeaderSection(
                          onSettingsTap: onSettingsTap,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 85.h),
                          child: MainProfileCardSection(
                            profile: profile,
                            onEditProfileTap: () {
                              context.push(
                                AppRoutes.editProfile,
                                extra: cubit,
                              );
                            },
                            onUpdatePhoto: (path) {
                              cubit.updateProfileImage(path);
                            },
                            onRemovePhoto: () {
                              cubit.removeProfileImage();
                            },
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // Stats Row Card (4 columns with IntrinsicHeight & VerticalDividers)
                    StatsCardSection(profile: profile),

                    // Custom Rounded Tab Bar (About / Portfolio / Reviews)
                    CustomTabBarSection(
                      selectedIndex: selectedTab,
                      onTabSelected: (index) {
                        cubit.selectTab(index);
                      },
                    ),

                    // Tab Content
                    if (selectedTab == 0) ...[
                      // About Tab Content
                      CompanyInfoSection(profile: profile),
                      AboutMeSection(
                        profile: profile,
                        onSaveBio: (newBio) {
                          cubit.updateAboutMe(newBio);
                        },
                      ),
                      SpecializationSection(
                        profile: profile,
                        onAddSpecialization: (item) {
                          cubit.addSpecialization(item);
                        },
                        onRemoveSpecialization: (item) {
                          cubit.removeSpecialization(item);
                        },
                      ),
                      CoveredGovernoratesSection(
                        profile: profile,
                        onAddCity: (city) {
                          cubit.addCoveredGovernorate(city);
                        },
                        onRemoveCity: (city) {
                          cubit.removeCoveredGovernorate(city);
                        },
                      ),
                      PortfolioSection(
                        profile: profile,
                        onViewAllTap: () {
                          if (onNavigateToMyProjects != null) {
                            onNavigateToMyProjects!();
                          } else {
                            cubit.selectTab(1);
                          }
                        },
                      ),
                    ] else if (selectedTab == 1) ...[
                      // Portfolio Tab Content
                      PortfolioSection(
                        profile: profile,
                        onViewAllTap: onNavigateToMyProjects,
                      ),
                    ] else ...[
                      // Reviews Tab Content
                      CompanyInfoSection(profile: profile),
                    ],

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: showBottomNavBar
          ? const ContractorProfileBottomNavBar(
              currentIndex: 4,
            )
          : null,
    );
  }
}
