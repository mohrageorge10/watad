import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

import '../../data/repositories/mock_change_orders_repository.dart';
import '../cubit/change_orders_cubit.dart';
import '../cubit/change_orders_state.dart';
import '../widgets/pending_change_orders_card.dart';
import '../widgets/recent_change_orders_list.dart';

class ChangeOrdersView extends StatelessWidget {
  const ChangeOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangeOrdersCubit(MockChangeOrdersRepository())..fetchChangeOrders(),
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
          title: BlocBuilder<ChangeOrdersCubit, ChangeOrdersState>(
            builder: (context, state) {
              String title = "Change Orders";
              if (state is ChangeOrdersLoaded) {
                title = state.data.projectName;
              }
              return Text(
                title,
                style: AppTextStyles.font16SemiBold.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
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
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              } else if (state is ChangeOrdersError) {
                return Center(child: Text("Error: ${state.message}"));
              } else if (state is ChangeOrdersLoaded) {
                final data = state.data;
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PendingChangeOrdersCard(
                        pendingCount: data.pendingCount,
                        pendingAmount: data.pendingAmount,
                        eotDays: data.eotDays,
                        eotAmount: data.eotAmount,
                      ),
                      SizedBox(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recent Change Orders",
                            style: AppTextStyles.font16SemiBold.copyWith(
                              color: AppColors.grey900,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "View All",
                              style: AppTextStyles.font14SemiBoldDark.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      RecentChangeOrdersList(items: data.recentChangeOrders),
                      SizedBox(height: 32.h),
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            "View All Change Orders",
                            style: AppTextStyles.font16SemiBold.copyWith(
                              color: AppColors.white100,
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
