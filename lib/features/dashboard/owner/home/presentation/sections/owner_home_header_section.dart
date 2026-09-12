import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_profile_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_profile_state.dart';
import 'package:watad/features/dashboard/owner/main_layout/presentation/cubit/main_layout_cubit.dart';

class OwnerHomeHeaderSection extends StatelessWidget {
  const OwnerHomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => context.read<MainLayoutCubit>().changeBottomNavIndex(4),
            child: Icon(Icons.person_outline, color: AppColors.grey900, size: 28.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<HomeProfileCubit, HomeProfileState>(
                  builder: (context, state) {
                    String name = "Welcome,";
                    if (state is HomeProfileLoaded) {
                      name = "Welcome ${state.profile.fullName},";
                    } else if (state is HomeProfileLoading) {
                      name = "Loading...";
                    }
                    return Text(
                      name,
                      style: AppTextStyles.font16SemiBold.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                SizedBox(height: 2.h),
                Text(
                  "Ready to build your dream home ?",
                  style: AppTextStyles.font12MediumGrey.copyWith(
                    color: AppColors.grey900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => context.read<MainLayoutCubit>().changeBottomNavIndex(3),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.grey900,
                  size: 26.sp,
                ),
                Positioned(
                  top: 2.h,
                  right: 2.w,
                  child: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: const BoxDecoration(
                      color: AppColors.alert,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
