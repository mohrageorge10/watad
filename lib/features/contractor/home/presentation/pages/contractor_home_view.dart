import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_home_cubit.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_home_state.dart';
import 'package:watad/features/contractor/home/presentation/view/sections/active_projects_section.dart';
import 'package:watad/features/contractor/home/presentation/view/sections/complete_profile_section.dart';
import 'package:watad/features/contractor/home/presentation/view/sections/contractor_header_section.dart';
import 'package:watad/features/contractor/home/presentation/view/sections/contractor_home_shimmer_section.dart';
import 'package:watad/features/contractor/home/presentation/view/sections/explore_marketplace_section.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/home/presentation/view/sections/recent_bids_section.dart';

class ContractorHomeView extends StatelessWidget {
  const ContractorHomeView({
    super.key,
    this.onNavigateToMarketplace,
    this.onNavigateToProfile,
    this.onNavigateToBids,
  });

  final VoidCallback? onNavigateToMarketplace;
  final VoidCallback? onNavigateToProfile;
  final VoidCallback? onNavigateToBids;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.signUp,
      body: BlocBuilder<ContractorHomeCubit, ContractorHomeState>(
        builder: (context, state) {
          if (state is ContractorHomeLoading) {
            return const ContractorHomeShimmerSection();
          }

          if (state is ContractorHomeError) {
            return AppEmptyStateWidget(
              title: 'Something went wrong',
              message: state.message,
              buttonTitle: 'Try Again',
              onButtonPressed: () {
                context.read<ContractorHomeCubit>().loadHomeData();
              },
            );
          }

          if (state is ContractorHomeSuccess || state is ContractorHomeEmpty) {
            final homeData = state is ContractorHomeSuccess
                ? state.homeData
                : (state as ContractorHomeEmpty).homeData;

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<ContractorHomeCubit>().loadHomeData();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header Section
                    ContractorHeaderSection(
                      userName: homeData.userName,
                      headline: homeData.headline,
                      onNotificationTap: () {},
                      onProfileTap: onNavigateToProfile,
                    ),

                    // 2. Complete Profile Floating Card (only shown if profile is incomplete)
                    if (!homeData.isProfileComplete)
                      CompleteProfileSection(
                        text: homeData.completeProfileText,
                        onTap: onNavigateToProfile,
                      ),

                    // 3. Active Projects Section (decides internally whether to show items or empty card)
                    ActiveProjectsSection(
                      projects: homeData.activeProjects,
                      ongoingCount: homeData.ongoingProjectsCount,
                      onViewAllTap: () {},
                      onProjectTap: (project) {},
                      onExploreTap: onNavigateToMarketplace,
                    ),

                    // 4. Explore Marketplace Section
                    SizedBox(height: 24.h),
                    ExploreMarketplaceSection(
                      onTap: onNavigateToMarketplace,
                    ),

                    // 5. Recent Bids Section (decides internally whether to show items or empty card)
                    SizedBox(height: 24.h),
                    RecentBidsSection(
                      bids: homeData.recentBids,
                      onViewAllTap: onNavigateToBids ??
                          () {
                            context.push(AppRoutes.myBids);
                          },
                      onBidTap: (bid) {
                        context.push(
                          AppRoutes.bidDetails,
                          extra: MyBidEntity(
                            id: bid.id,
                            title: bid.title,
                            location: bid.location,
                            image: bid.image,
                            status: bid.badgeText,
                            statusColorHex: bid.badgeColorHex,
                            isBookmarked: false,
                            yourBid: bid.amount,
                            duration: '6 Months',
                            submittedDate: 'Recently',
                          ),
                        );
                      },
                      onBrowseTendersTap: onNavigateToMarketplace,
                    ),

                    SizedBox(height: 32.h),
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
