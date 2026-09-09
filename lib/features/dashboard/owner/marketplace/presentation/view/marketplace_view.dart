import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/sections/bids_market_section.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/sections/smart_matching_section.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MarketplaceView extends StatelessWidget {
  const MarketplaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MarketplaceCubit>()..initMarketplace(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: AppColors.secondBackground,
          appBar: AppBar(
            backgroundColor: AppColors.secondBackground,
            elevation: 0,
            title: Text(
              'Marketplace',
              style: AppTextStyles.font24Bold.copyWith(color: AppColors.primary),
            ),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: AppColors.primary,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.deactivation,
              indicatorWeight: 3.h,
              labelStyle: AppTextStyles.font16SemiBold,
              unselectedLabelStyle: AppTextStyles.font16SemiBold,
              tabs: const [
                Tab(text: 'Smart Matching'),
                Tab(text: 'Bids Market'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              SmartMatchingSection(),
              BidsMarketSection(),
            ],
          ),
        ),
      ),
    );
  }
}
