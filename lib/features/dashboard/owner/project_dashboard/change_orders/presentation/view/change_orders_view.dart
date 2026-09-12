import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';

import '../cubit/change_orders_cubit.dart';
import '../cubit/change_orders_state.dart';
import '../widgets/recent_change_orders_list.dart';

class ChangeOrdersView extends StatelessWidget {
  const ChangeOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangeOrdersCubit>()..fetchChangeOrders(),
      child: Scaffold(
        backgroundColor: AppColors.secondBackground,
        appBar: AppBar(
          backgroundColor: AppColors.white100,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
            onPressed: () => context.pop(),
          ),
          centerTitle: true,
          title: Text(
            "Change Orders",
            style: AppTextStyles.font16SemiBold.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.r),
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ChangeOrdersCubit, ChangeOrdersState>(
            builder: (context, state) {
              if (state is ChangeOrdersLoading) {
                return Padding(
                  padding: EdgeInsets.all(24.w),
                  child: const ListShimmer(),
                );
              } else if (state is ChangeOrdersError) {
                return Center(
                  child: AppEmptyStateWidget(
                    title: "Error Loading Change Orders",
                    message: state.message,
                    buttonTitle: "Retry",
                    onButtonPressed: () {
                      context.read<ChangeOrdersCubit>().fetchChangeOrders();
                    },
                  ),
                );
              } else if (state is ChangeOrdersLoaded) {
                final data = state.data;
                final recentChangeOrders = data.recentChangeOrders;
                
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recent Change Orders",
                        style: AppTextStyles.font16SemiBold.copyWith(
                          color: AppColors.grey900,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      if (recentChangeOrders.isEmpty)
                        const AppEmptyStateWidget(
                          title: "No change orders yet.",
                        )
                      else
                        RecentChangeOrdersList(items: recentChangeOrders),
                      SizedBox(height: 24.h),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push(AppRoutes.allChangeOrders);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white100,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              side: const BorderSide(color: AppColors.primary),
                            ),
                          ),
                          child: Text(
                            'View All Change Orders',
                            style: AppTextStyles.font10MediumWhite.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
