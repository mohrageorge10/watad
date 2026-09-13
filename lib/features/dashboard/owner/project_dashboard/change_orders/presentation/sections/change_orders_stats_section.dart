import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import '../../domain/entities/all_change_orders_data.dart';
import '../widgets/change_order_formatters.dart';
import '../widgets/change_order_stat_card.dart';

class ChangeOrdersStatsSection extends StatelessWidget {
  final ChangeOrdersStats stats;

  const ChangeOrdersStatsSection({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ChangeOrderStatCard(
              iconPath: 'assets/icons/ic_pending_clock.svg',
              iconColor: AppColors.icon,
              iconBackgroundColor: AppColors.icon.withValues(alpha: 0.18),
              value: '${stats.pendingCount}',
              valueColor: AppColors.smallText,
              title: 'Pending',
              subtitle: 'Awaiting decision',
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: ChangeOrderStatCard(
              iconPath: 'assets/icons/ic_cost_impact.svg',
              iconColor: AppColors.accept,
              iconBackgroundColor: AppColors.accept.withValues(alpha: 0.12),
              value: ChangeOrderFormatters.costImpact(stats.pendingCostImpact),
              valueColor: AppColors.accept,
              title: 'Cost Impact',
              subtitle: 'From pending orders',
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: ChangeOrderStatCard(
              iconPath: 'assets/icons/ic_days_impact.svg',
              iconColor: AppColors.primary,
              iconBackgroundColor: AppColors.primary.withValues(alpha: 0.10),
              value: '${stats.pendingDaysImpact >= 0 ? '+' : ''}${stats.pendingDaysImpact}',
              valueColor: AppColors.primary,
              title: 'Days Impact',
              subtitle: 'From pending orders',
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: ChangeOrderStatCard(
              iconPath: 'assets/icons/ic_total_orders.svg',
              iconColor: AppColors.primary600,
              iconBackgroundColor: AppColors.primary600.withValues(alpha: 0.12),
              value: '${stats.totalOrders}',
              valueColor: AppColors.smallText,
              title: 'Total Orders',
              subtitle: 'All time',
            ),
          ),
        ],
      ),
    );
  }
}
