import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/financial_summary_data.dart';

class BudgetBreakdownCard extends StatelessWidget {
  final List<BudgetBreakdownItem> breakdowns;

  const BudgetBreakdownCard({super.key, required this.breakdowns});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        children: breakdowns.map((item) => _buildBreakdownRow(item)).toList(),
      ),
    );
  }

  Widget _buildBreakdownRow(BudgetBreakdownItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    item.title,
                    style: AppTextStyles.font14Medium.copyWith(
                      color: AppColors.deactivation,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            '${item.value} (${item.percentage})',
            style: AppTextStyles.font14SemiBoldDark,
          ),
        ],
      ),
    );
  }
}
