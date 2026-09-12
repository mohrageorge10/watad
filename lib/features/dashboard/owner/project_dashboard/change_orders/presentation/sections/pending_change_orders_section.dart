import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import '../../domain/entities/change_order_details.dart';
import '../widgets/pending_change_order_card.dart';

class PendingChangeOrdersSection extends StatelessWidget {
  final List<ChangeOrderDetails> orders;

  const PendingChangeOrdersSection({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Pending Change Orders',
                style: AppTextStyles.font14SemiBoldDark.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.allChangeOrders),
              child: Text(
                'View All',
                style: AppTextStyles.font12MediumGrey.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (orders.isEmpty)
          const AppEmptyStateWidget(
            title: 'No pending change orders',
            message: 'New pending orders will appear here.',
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final order = orders[index];
              return PendingChangeOrderCard(
                order: order,
                onViewDetails: () {
                  AppToast.showInfo(context, order.title);
                },
                onReject: () {
                  AppToast.showError(context, '${order.id} rejected');
                },
                onAccept: () {
                  AppToast.showSuccess(context, '${order.id} accepted');
                },
              );
            },
          ),
      ],
    );
  }
}
