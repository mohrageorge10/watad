import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/marketplace_state.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/widgets/owner_bid_card_widget.dart';

class BidsMarketSection extends StatelessWidget {
  const BidsMarketSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceCubit, MarketplaceState>(
      buildWhen: (previous, current) => previous.bidsState != current.bidsState,
      builder: (context, state) {
        if (state.bidsState == RequestState.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.bidsState == RequestState.error) {
          return Center(
            child: AppEmptyStateWidget(
              title: 'Failed to load bids',
              message: state.bidsErrorMessage.isNotEmpty
                  ? state.bidsErrorMessage
                  : 'An error occurred while fetching bids.',
              buttonTitle: 'Try Again',
              onButtonPressed: () {
                context.read<MarketplaceCubit>().initMarketplace();
              },
            ),
          );
        }

        if (state.bidsState == RequestState.empty || state.bids.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              await context.read<MarketplaceCubit>().initMarketplace();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: const AppEmptyStateWidget(
                    title: 'No Bids Yet',
                    message: 'You have not received any bids for your project yet.',
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bids Received (${state.bids.length})',
                    style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary),
                  ),
                  Row(
                    children: [
                      Text(
                        'Sort: ',
                        style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.grey900),
                      ),
                      DropdownButton<String>(
                        value: 'Lowest Cost',
                        icon: Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Icon(Icons.keyboard_arrow_down, size: 20.r, color: AppColors.grey900),
                        ),
                        underline: const SizedBox(),
                        style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.grey900),
                        onChanged: (String? newValue) {
                          // Handle sort change
                        },
                        items: <String>['Lowest Cost', 'Highest Cost', 'Newest']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await context.read<MarketplaceCubit>().initMarketplace();
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  itemCount: state.bids.length,
                  itemBuilder: (context, index) {
                    final bid = state.bids[index];
                    return OwnerBidCardWidget(
                      bid: bid,
                      index: index,
                      onTap: () async {
                        await context.pushNamed(AppRoutes.ownerBidDetails, extra: bid.id);
                        if (context.mounted) {
                          context.read<MarketplaceCubit>().initMarketplace();
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
