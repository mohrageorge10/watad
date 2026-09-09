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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.id,
            style: AppTextStyles.font14SemiBoldDark.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            item.title,
            style: AppTextStyles.font12MediumGrey.copyWith(
              color: AppColors.grey500,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.amount,
                    style: AppTextStyles.font14SemiBoldDark.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    item.date,
                    style: AppTextStyles.font12RegularGrey.copyWith(
                      fontSize: 10.sp,
                      color: AppColors.grey400,
                    ),
                  ),
                ],
              ),
              _buildStatusWidget(item.status),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusWidget(ChangeOrderStatus status) {
    if (status == ChangeOrderStatus.review) {
      return SizedBox(
        height: 32.h,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            elevation: 0,
          ),
          child: Text(
            "Review",
            style: AppTextStyles.font12MediumGrey.copyWith(
              color: AppColors.white100,
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.accept,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          "Approved",
          style: AppTextStyles.font12MediumGrey.copyWith(
            color: AppColors.white100,
          ),
        ),
      );
    }
  }
}
