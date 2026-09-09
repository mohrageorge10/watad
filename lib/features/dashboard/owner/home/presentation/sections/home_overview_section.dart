import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_overview_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_overview_state.dart';
import 'package:watad/features/dashboard/owner/main_layout/presentation/cubit/main_layout_cubit.dart';
import 'active_project_card_section.dart';

class HomeOverviewSection extends StatelessWidget {
  const HomeOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeOverviewCubit, HomeOverviewState>(
      builder: (context, state) {
        if (state is HomeOverviewLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary)),
          );
        } else if (state is HomeOverviewLoaded) {
          return ActiveProjectCardSection(
            project: state.data,
            onGoToDashboard: () {
              context.read<MainLayoutCubit>().changeBottomNavIndex(1);
            },
          );
        } else if (state is HomeOverviewEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.white100,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.signUp),
              ),
              child: Center(
                child: Text(
                  "No Active Project. Start one!",
                  style: AppTextStyles.font14SemiBoldDark,
                ),
              ),
            ),
          );
        } else if (state is HomeOverviewError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
