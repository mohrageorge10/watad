import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/marketplace_state.dart';

class BidsMarketSection extends StatelessWidget {
  const BidsMarketSection({super.key});

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      // Fallback manual formatting without intl package to avoid missing dependencies
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      final month = months[dateTime.month - 1];
      final hour = dateTime.hour > 12 ? dateTime.hour - 12 : (dateTime.hour == 0 ? 12 : dateTime.hour);
      final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
      final min = dateTime.minute.toString().padLeft(2, '0');
      return '${dateTime.day} $month ${dateTime.year} - $hour:$min $amPm';
    } catch (e) {
      return dateString;
    }
  }

  Color _getTagColor(int index, String status) {
    if (index == 0) return Colors.green; // Lowest
    if (index == 1) return const Color(0xFF2E5BFF); // 2nd Lowest (blue)
    return AppColors.grey500; // Viewed / Other
  }

  String _getTagText(int index, String status) {
    if (index == 0) return 'Lowest';
    if (index == 1) return '2nd Lowest';
    return 'Viewed';
  }

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
            child: Text(state.bidsErrorMessage, textAlign: TextAlign.center),
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
                  return GestureDetector(
                    onTap: () async {
                      await context.pushNamed('bid_details', extra: bid.id);
                      if (context.mounted) {
                        context.read<MarketplaceCubit>().initMarketplace();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.white100,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.grey200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48.r,
                                height: 48.r,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.grey200,
                                ),
                                child: Icon(Icons.person, color: AppColors.grey500, size: 24.r),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 2.h),
                                    Text(
                                      bid.contractorName,
                                      style: AppTextStyles.font16SemiBold,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      '${bid.amount} EGP',
                                      style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary700),
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time, size: 14.r, color: AppColors.grey500),
                                        SizedBox(width: 4.w),
                                        Text(
                                          '${bid.durationDays} Days',
                                          style: AppTextStyles.font12MediumGrey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: _getTagColor(index, bid.status),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  _getTagText(index, bid.status),
                                  style: AppTextStyles.font12MediumGrey.copyWith(color: AppColors.white100),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            _formatDate(bid.date),
                            style: AppTextStyles.font12MediumGrey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            )],
        );
      },
    );
  }
}
