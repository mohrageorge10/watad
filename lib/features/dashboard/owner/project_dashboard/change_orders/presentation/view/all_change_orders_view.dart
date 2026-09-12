import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/theme/app_colors.dart';
import '../../domain/usecases/get_all_change_orders_usecase.dart';
import '../cubit/all_change_orders_cubit.dart';
import '../cubit/all_change_orders_state.dart';
import '../sections/change_orders_stats_section.dart';
import '../sections/pending_change_orders_section.dart';
import '../widgets/all_change_orders_shimmer.dart';
import '../widgets/change_orders_page_header.dart';

import 'package:watad/core/di/service_locator.dart';

class AllChangeOrdersView extends StatelessWidget {
  const AllChangeOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AllChangeOrdersCubit>()..loadChangeOrders(),
      child: const AllChangeOrdersBody(),
    );
  }
}

class AllChangeOrdersBody extends StatelessWidget {
  const AllChangeOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
              child: const ChangeOrdersPageHeader(title: 'Change Orders'),
            ),
            Expanded(
              child: BlocBuilder<AllChangeOrdersCubit, AllChangeOrdersState>(
                builder: (context, state) {
                  if (state is AllChangeOrdersLoading ||
                      state is AllChangeOrdersInitial) {
                    return const AllChangeOrdersShimmer();
                  }
                  if (state is AllChangeOrdersError) {
                    return AppEmptyStateWidget(
                      title: 'Unable to load change orders',
                      message: state.message,
                    );
                  }
                  if (state is AllChangeOrdersEmpty) {
                    return const AppEmptyStateWidget(
                      title: 'No change orders yet',
                      message: 'Change orders for this project will appear here.',
                    );
                  }
                  if (state is AllChangeOrdersLoaded) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                      child: Column(
                        children: [
                          ChangeOrdersStatsSection(stats: state.data.stats),
                          SizedBox(height: 20.h),
                          PendingChangeOrdersSection(
                            orders: state.data.pendingOrders,
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
