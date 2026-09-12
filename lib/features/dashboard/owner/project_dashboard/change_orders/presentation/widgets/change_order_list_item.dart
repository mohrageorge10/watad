import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import '../../domain/entities/change_order_item.dart';

class ChangeOrderListItem extends StatelessWidget {
  final ChangeOrderItem item;

  const ChangeOrderListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 16.h),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "by ${item.requestedByUserId}",
                  style: AppTextStyles.font14SemiBoldDark.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  item.costImpact,
                  style: AppTextStyles.font14SemiBoldDark.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  item.createdAt,
                  style: AppTextStyles.font12RegularGrey.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),
          ),
          _buildStatusWidget(item.status),
        ],
      ),
    );
  }

  Widget _buildStatusWidget(String status) {
    Color bgColor = AppColors.grey100;
    Color textColor = AppColors.grey600;

    final lowerStatus = status.toLowerCase();
    if (lowerStatus.contains("approved")) {
      bgColor = AppColors.accept;
      textColor = AppColors.white100;
    } else if (lowerStatus.contains("pending") || lowerStatus.contains("review")) {
      bgColor = AppColors.accent;
      textColor = AppColors.white100;
    } else if (lowerStatus.contains("rejected")) {
      bgColor = AppColors.alert;
      textColor = AppColors.white100;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: AppTextStyles.font12MediumGrey.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
