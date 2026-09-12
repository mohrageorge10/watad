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
                      GestureDetector(
                        onTap: () {
                          context.push(AppRoutes.allChangeOrders);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.pending_actions_outlined, color: AppColors.primary, size: 20.w),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  "Pending Change Orders",
                                  style: AppTextStyles.font14Medium.copyWith(
                                    color: AppColors.grey900,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 36.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.push(AppRoutes.allChangeOrders);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                                  ),
                                  child: Text(
                                    "Review",
                                    style: AppTextStyles.font14MediumWhite.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.calendar_today_outlined, color: AppColors.primary, size: 20.w),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                "Add change order",
                                style: AppTextStyles.font14Medium.copyWith(
                                  color: AppColors.grey900,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 36.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  context.push(AppRoutes.createChangeOrder);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                                ),
                                child: Text(
                                  "New",
                                  style: AppTextStyles.font14MediumWhite.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
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
                      SizedBox(height: 16.h),
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
