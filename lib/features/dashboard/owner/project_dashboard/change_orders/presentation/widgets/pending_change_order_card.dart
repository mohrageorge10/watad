import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import '../../domain/entities/change_order_details.dart';
import 'change_order_card_actions.dart';
import 'change_order_formatters.dart';
import 'change_order_impact_item.dart';
import 'change_order_status_badge.dart';

class PendingChangeOrderCard extends StatelessWidget {
  final ChangeOrderDetails order;
  final VoidCallback? onViewDetails;
  final VoidCallback? onReject;
  final VoidCallback? onAccept;

  const PendingChangeOrderCard({
    super.key,
    required this.order,
    this.onViewDetails,
    this.onReject,
    this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black100.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  order.description,
                  style: AppTextStyles.font14SemiBoldDark.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              ChangeOrderStatusBadge(status: order.status),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: ChangeOrderImpactItem(
                  iconPath: 'assets/icons/ic_cost_impact.svg',
                  color: AppColors.accept,
                  value: ChangeOrderFormatters.costImpact(order.costImpact),
                  label: 'Cost Impact',
                ),
              ),
              Expanded(
                child: ChangeOrderImpactItem(
                  iconPath: 'assets/icons/ic_time_impact.svg',
                  color: AppColors.primary,
                  value: ChangeOrderFormatters.daysImpact(order.timeImpactDays),
                  label: 'Time Impact',
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Date: ${ChangeOrderFormatters.date(order.createdAt)}',
                  style: AppTextStyles.font12RegularGrey.copyWith(
                    color: AppColors.deactivation,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ChangeOrderCardActions(
            onViewDetails: onViewDetails,
            onReject: onReject,
            onAccept: onAccept,
          ),
        ],
      ),
    );
  }
}
