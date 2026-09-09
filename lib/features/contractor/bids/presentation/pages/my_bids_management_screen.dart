import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/my_bids_cubit.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/my_bids_state.dart';
import 'package:watad/features/contractor/bids/presentation/view/sections/my_bids_header_section.dart';
import 'package:watad/features/contractor/bids/presentation/view/sections/my_bids_list_section.dart';
import 'package:watad/features/contractor/bids/presentation/view/widgets/my_bids_filter_chips_widget.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_bottom_nav_bar.dart';

class MyBidsManagementScreen extends StatelessWidget {
  final bool showBottomNavBar;
  final bool showBackButton;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const MyBidsManagementScreen({
    super.key,
    this.showBottomNavBar = true,
    this.showBackButton = false, // Explicitly requested: without back arrow
    this.onBackTap,
    this.onSettingsTap,
  });

  void _onBottomNavTapped(BuildContext context, int index) {
    if (index == 3) return; // Already on My Bids

    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.push(AppRoutes.marketplace);
        break;
      case 2:
        context.push(AppRoutes.portfolioProjects);
        break;
      case 4:
        context.push(AppRoutes.contractorProfile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyBidsCubit()..loadBids(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Section (Curved primary app bar without back arrow)
              MyBidsHeaderSection(
                title: 'My Bids Management',
                showBackButton: showBackButton,
                onBackTap: onBackTap,
                onSettingsTap: onSettingsTap,
              ),

              // 2. Filter Chips Section
              BlocBuilder<MyBidsCubit, MyBidsState>(
                builder: (context, state) {
                  final activeFilter = state is MyBidsSuccess
                      ? state.activeFilter
                      : (state is MyBidsLoading
                          ? state.activeFilter
                          : 'All');
                  final allCount = state is MyBidsSuccess ? state.allCount : 5;
                  final pendingCount =
                      state is MyBidsSuccess ? state.pendingCount : 2;
                  final acceptedCount =
                      state is MyBidsSuccess ? state.acceptedCount : 2;
                  final rejectedCount =
                      state is MyBidsSuccess ? state.rejectedCount : 1;

                  return MyBidsFilterChipsWidget(
                    activeFilter: activeFilter,
                    allCount: allCount,
                    pendingCount: pendingCount,
                    acceptedCount: acceptedCount,
                    rejectedCount: rejectedCount,
                    onFilterSelected: (filter) {
                      context.read<MyBidsCubit>().changeFilter(filter);
                    },
                  );
                },
              ),

              // 3. Bids List Section
              const MyBidsListSection(),

              SizedBox(height: 24.h),
            ],
          ),
        ),
        bottomNavigationBar: showBottomNavBar
            ? SafeArea(
                top: false,
                child: ContractorBottomNavBar(
                  currentIndex: 3, // My Bids is active
                  onTap: (index) => _onBottomNavTapped(context, index),
                ),
              )
            : null,
      ),
    );
  }
}
