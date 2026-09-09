import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_text_styles.dart';

class TotalBudgetCard extends StatelessWidget {
  final String totalBudget;

  const TotalBudgetCard({super.key, required this.totalBudget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL BUDGET',
                style: AppTextStyles.font10MediumWhite.copyWith(
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                totalBudget,
                style: AppTextStyles.font24Bold.copyWith(
                  color: AppColors.white100,
                  fontSize: 22.sp,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.primary,
              size: 28.sp,
            ),
          ),
        ],
      ),
    );
  }
}
