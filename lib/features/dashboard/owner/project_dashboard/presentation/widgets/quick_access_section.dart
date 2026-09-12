import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/routing/app_routes.dart';
import '../../../main_layout/presentation/cubit/main_layout_cubit.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/dashboard_data.dart';

class QuickAccessSection extends StatelessWidget {
  final List<QuickAccessItem> items;

  const QuickAccessSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Access',
          style: AppTextStyles.font14SemiBoldDark.copyWith(
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.map((item) => _buildQuickAccessCard(context, item)).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickAccessCard(BuildContext context, QuickAccessItem item) {
    return GestureDetector(
      onTap: () {
        if (item.title.contains('Financial')) {
          context.push(AppRoutes.financialSummary);
        } else if (item.title.contains('Progress')) {
          context.push(AppRoutes.progressSiteUpdates);
        } else if (item.title.contains('Change')) {
          context.push(AppRoutes.changeOrders);
        } else if (item.title.contains('Alerts')) {
          // MainLayoutCubit manages the bottom nav bar. Index 3 is Alerts.
          context.read<MainLayoutCubit>().changeBottomNavIndex(3);
        }
      },
      child: Container(
        width: 76.w,
      height: 90.h,
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                item.iconData,
                color: AppColors.primary,
                size: 24.sp,
              ),
              if (item.notificationCount > 0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: const BoxDecoration(
                      color: AppColors.icon,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${item.notificationCount}',
                      style: TextStyle(
                        color: AppColors.white100,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.font10MediumDark.copyWith(
              fontSize: 9.sp,
              height: 1.2,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
