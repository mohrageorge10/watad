import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class PendingChangeOrdersCard extends StatelessWidget {
  final int pendingCount;
  final String pendingAmount;
  final String eotDays;
  final String eotAmount;

  const PendingChangeOrdersCard({
    super.key,
    required this.pendingCount,
    required this.pendingAmount,
    required this.eotDays,
    required this.eotAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCard(
          icon: Icons.warning_amber_rounded,
          iconColor: Colors.red,
          title: "Pending Change Orders",
          badgeText: pendingCount.toString(),
          amountText: pendingAmount,
          buttonText: "Review",
        ),
        SizedBox(height: 16.h),
        _buildCard(
          icon: Icons.calendar_today_outlined,
          iconColor: AppColors.primary,
          title: "Add an EOT Request",
          badgeText: eotDays,
          amountText: eotAmount,
          buttonText: "New",
        ),
      ],
    );
  }

  Widget _buildCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String badgeText,
    required String amountText,
    required String buttonText,
  }) {
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        style: AppTextStyles.font14SemiBoldDark.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      badgeText,
                      style: AppTextStyles.font12MediumGrey.copyWith(
                        color: AppColors.grey900,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  amountText,
                  style: AppTextStyles.font14SemiBoldDark.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
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
                buttonText,
                style: AppTextStyles.font12MediumGrey.copyWith(
                  color: AppColors.white100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
