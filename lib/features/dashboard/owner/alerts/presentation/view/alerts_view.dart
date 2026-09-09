import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

import '../../data/repositories/mock_alerts_repository.dart';
import '../cubit/alerts_cubit.dart';
import '../cubit/alerts_state.dart';
import '../widgets/alert_card.dart';
import '../widgets/alert_category_chips.dart';

class AlertsView extends StatelessWidget {
  const AlertsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlertsCubit(MockAlertsRepository())..fetchAlerts(),
      child: Scaffold(
        backgroundColor: AppColors.secondBackground,
        body: SafeArea(
          child: Column(
            children: [
              // Custom Header matching the reference
              Container(
                margin: EdgeInsets.all(24.w).copyWith(bottom: 16.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      // Emulate returning to Dashboard home by popping or just use an icon if we are in main tab
                      // Here we just provide the icon as per design.
                      onTap: () {
                        // We will rely on MainLayoutCubit to switch tab, but typically
                        // bottom nav icons don't need a back button if they are roots.
                        // For the visual sake:
                      },
                      child: const Icon(Icons.arrow_back, color: AppColors.primary),
                    ),
                    Expanded(
                      child: Text(
                        "Alerts",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font16SemiBold.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 24.w), // Balance the back arrow
                  ],
                ),
              ),

              // Content Area
              Expanded(
                child: BlocBuilder<AlertsCubit, AlertsState>(
                  builder: (context, state) {
                    if (state is AlertsLoading) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                    } else if (state is AlertsError) {
                      return Center(child: Text("Error: ${state.message}"));
                    } else if (state is AlertsLoaded) {
                      return Column(
                        children: [
                          // Filter Chips
                          AlertCategoryChips(
                            categories: const ['All', 'Critical', 'Warning', 'Info'],
                            activeCategory: state.activeCategory,
                            onCategorySelected: (category) {
                              context.read<AlertsCubit>().filterCategory(category);
                            },
                          ),
                          SizedBox(height: 24.h),

                          // Scrollable Alerts List
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Today Section
                                  if (state.data.todayAlerts.isNotEmpty) ...[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Today",
                                          style: AppTextStyles.font14SemiBoldDark.copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                          decoration: BoxDecoration(
                                            color: AppColors.white100,
                                            borderRadius: BorderRadius.circular(20.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.04),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Sort By Category",
                                                style: AppTextStyles.font12MediumGrey.copyWith(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              SizedBox(width: 4.w),
                                              Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 16.sp),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16.h),
                                    ...state.data.todayAlerts.map((alert) => AlertCard(alert: alert)),
                                  ],

                                  SizedBox(height: 16.h),

                                  // Earlier Section
                                  if (state.data.earlierAlerts.isNotEmpty) ...[
                                    Text(
                                      "Earlier",
                                      style: AppTextStyles.font14SemiBoldDark.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    ...state.data.earlierAlerts.map((alert) => AlertCard(alert: alert)),
                                  ],
                                  
                                  SizedBox(height: 40.h),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
