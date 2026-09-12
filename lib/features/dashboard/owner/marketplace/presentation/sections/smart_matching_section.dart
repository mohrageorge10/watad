import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/marketplace_state.dart';

class SmartMatchingSection extends StatelessWidget {
  const SmartMatchingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceCubit, MarketplaceState>(
      buildWhen: (previous, current) => previous.contractorsState != current.contractorsState,
      builder: (context, state) {
        if (state.contractorsState == RequestState.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.contractorsState == RequestState.error) {
          return Center(
            child: AppEmptyStateWidget(
              title: 'Failed to load contractors',
              message: state.contractorsErrorMessage.isNotEmpty
                  ? state.contractorsErrorMessage
                  : 'An error occurred while finding matching contractors.',
              buttonTitle: 'Try Again',
              onButtonPressed: () {
                context.read<MarketplaceCubit>().initMarketplace();
              },
            ),
          );
        }

        if (state.contractorsState == RequestState.empty || state.contractors.isEmpty) {
          return const AppEmptyStateWidget(
            title: 'No Recommended Contractors',
            message: 'We could not find any matching contractors for your project at the moment.',
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: state.contractors.length,
          itemBuilder: (context, index) {
            final profile = state.contractors[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.white100,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.grey200,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: profile.imageUrl.isNotEmpty
                            ? Image.network(
                                profile.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Icon(Icons.person, color: AppColors.grey500, size: 30.r),
                              )
                            : Icon(Icons.person, color: AppColors.grey500, size: 30.r),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.name,
                              style: AppTextStyles.font16SemiBold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.star_border, size: 18.r, color: Colors.orange),
                                SizedBox(width: 4.w),
                                Text(
                                  '${profile.rating.toStringAsFixed(1)} (${profile.reviewsCount})',
                                  style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey800),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Covered Governorates', style: AppTextStyles.font14Regular.copyWith(color: AppColors.primary)),
                            SizedBox(height: 4.h),
                            Text(
                              profile.coveredGovernorates, 
                              style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Specialization', style: AppTextStyles.font14Regular.copyWith(color: AppColors.primary)),
                            SizedBox(height: 4.h),
                            Text(profile.specialization, style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Years of Experience', style: AppTextStyles.font14Regular.copyWith(color: AppColors.primary)),
                            SizedBox(height: 4.h),
                            Text('${profile.yearsOfExperience} Years', style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: AppElevatedButton(
                          title: 'View Profile',
                          width: 100.w,
                          height: 30,
                          borderRadius: 20,
                          textStyle: AppTextStyles.font14Medium.copyWith(color: AppColors.white100),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
