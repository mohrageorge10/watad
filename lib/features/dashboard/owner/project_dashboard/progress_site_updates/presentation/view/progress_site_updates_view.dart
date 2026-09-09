import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

import '../../data/repositories/mock_progress_site_updates_repository.dart';
import '../cubit/progress_site_updates_cubit.dart';
import '../cubit/progress_site_updates_state.dart';
import '../widgets/overall_progress_card.dart';
import '../widgets/site_updates_grid.dart';

class ProgressSiteUpdatesView extends StatelessWidget {
  const ProgressSiteUpdatesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProgressSiteUpdatesCubit(MockProgressSiteUpdatesRepository())..fetchProgressSiteUpdates(),
      child: Scaffold(
        backgroundColor: AppColors.secondBackground,
        body: SafeArea(
          child: BlocBuilder<ProgressSiteUpdatesCubit, ProgressSiteUpdatesState>(
            builder: (context, state) {
              if (state is ProgressSiteUpdatesLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              } else if (state is ProgressSiteUpdatesError) {
                return Center(child: Text("Error: ${state.message}"));
              } else if (state is ProgressSiteUpdatesLoaded) {
                final data = state.data;
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(24.w).copyWith(bottom: 0),
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
                            onTap: () => context.pop(),
                            child: const Icon(Icons.arrow_back, color: AppColors.primary),
                          ),
                          Expanded(
                            child: Text(
                              "Progress & Site Updates",
                              textAlign: TextAlign.center,
                              style: AppTextStyles.font16SemiBold.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 24.w), // To balance the back arrow
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "View All",
                            style: AppTextStyles.font14SemiBoldDark.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      OverallProgressCard(
                        overallProgress: data.overallProgress,
                        phaseList: data.phaseProgressList,
                      ),
                      SizedBox(height: 32.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Site Updates (Photos)",
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
                      SiteUpdatesGrid(photos: data.siteUpdatePhotos),
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
      ),
    );
  }
}
