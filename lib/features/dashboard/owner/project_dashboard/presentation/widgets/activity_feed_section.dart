import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/dashboard_data.dart';

class ActivityFeedSection extends StatelessWidget {
  final List<ActivityFeedItem> items;

  const ActivityFeedSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today, 20 May',
          style: AppTextStyles.font14SemiBoldDark.copyWith(
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 16.h),
        ...items.map((item) => _buildActivityCard(item)),
      ],
    );
  }

  Widget _buildActivityCard(ActivityFeedItem item) {
    final isVerified = item.status == ActivityStatus.verified;
    
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppTextStyles.font12MediumGrey.copyWith(
                    color: AppColors.smallText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item.time,
                  style: AppTextStyles.font10MediumDark.copyWith(
                    color: AppColors.deactivation,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isVerified ? AppColors.accept : AppColors.icon,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              isVerified ? 'Verified' : 'Issue',
              style: AppTextStyles.font10MediumWhite.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
