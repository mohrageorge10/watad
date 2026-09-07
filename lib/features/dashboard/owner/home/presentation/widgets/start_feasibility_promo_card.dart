import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class StartFeasibilityPromoCard extends StatelessWidget {
  const StartFeasibilityPromoCard({super.key, required this.onCalculateNow});

  final VoidCallback onCalculateNow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.signUp),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start Smart Feasibility Calculation', style: AppTextStyles.font16SemiBold),
                SizedBox(height: 4.h),
                Text(
                  'Get an instant budget estimate and feasibility report for your land.',
                  style: AppTextStyles.font12Regular,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          ElevatedButton(
            onPressed: onCalculateNow,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              elevation: 0,
            ),
            child: Text('Calculate Now', style: AppTextStyles.btnWhite600),
          ),
        ],
      ),
    );
  }
}
