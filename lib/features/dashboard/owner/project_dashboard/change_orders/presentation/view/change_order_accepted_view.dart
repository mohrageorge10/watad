import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/domain/entities/change_order_details.dart';
import '../widgets/change_order_formatters.dart';

class ChangeOrderAcceptedView extends StatelessWidget {
  final ChangeOrderDetails order;

  const ChangeOrderAcceptedView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            children: [
              SizedBox(height: 48.h),
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.accept.withValues(alpha: 0.1),
                ),
                child: Center(
                  child: Icon(Icons.check_circle, color: AppColors.accept, size: 40.w),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Change Order Accepted!',
                style: AppTextStyles.font20SemiBold.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),

              Text(
                'The change order has been accepted successfully.',
                style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey50),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              Container(
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
                  children: [
                    _buildSummaryRow('Cost Impact', ChangeOrderFormatters.costImpact(order.costImpact), Icons.money, AppColors.accept),
                    Divider(color: AppColors.grey300, height: 24.h),
                    _buildSummaryRow('Time Impact', ChangeOrderFormatters.daysImpact(order.timeImpactDays), Icons.access_time, AppColors.primary),
                    Divider(color: AppColors.grey300, height: 24.h),
                    _buildSummaryRow('Status', 'Approved', Icons.check_circle_outline, AppColors.accept),
                  ],
                ),
              ),
              const Spacer(),
              AppElevatedButton(
                title: 'View All Change Orders',
                onPressed: () {
                  context.go(AppRoutes.allChangeOrders);
                },
                backgroundColor: AppColors.primary,
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon, Color valueColor) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accept, size: 20.w), // assuming icon color is accept or primary
        SizedBox(width: 12.w),
        Text(
          label,
          style: AppTextStyles.font14Regular.copyWith(color: AppColors.primary),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.font14SemiBoldDark.copyWith(color: valueColor),
        ),
      ],
    );
  }
}
