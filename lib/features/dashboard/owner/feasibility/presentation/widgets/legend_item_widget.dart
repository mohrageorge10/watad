import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:intl/intl.dart';

class LegendItemWidget extends StatelessWidget {
  final Color color;
  final String title;
  final double cost;
  final int percentage;

  const LegendItemWidget({
    super.key,
    required this.color,
    required this.title,
    required this.cost,
    required this.percentage,
  });

  String _formatCurrency(double amount) {
    final format = NumberFormat("#,##0", "en_US");
    return format.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 4.h),
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.font12Regular.copyWith(color: AppColors.grey900, fontWeight: FontWeight.w500),
              ),
              Text(
                '${_formatCurrency(cost)} ($percentage%)',
                style: AppTextStyles.font12Regular.copyWith(color: AppColors.grey500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
