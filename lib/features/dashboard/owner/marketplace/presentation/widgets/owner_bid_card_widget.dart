import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_card.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/project_bid.dart';

class OwnerBidCardWidget extends StatelessWidget {
  const OwnerBidCardWidget({
    super.key,
    required this.bid,
    required this.index,
    required this.onTap,
  });

  final ProjectBid bid;
  final int index;
  final VoidCallback onTap;

  static String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      final month = months[dateTime.month - 1];
      final hour = dateTime.hour > 12
          ? dateTime.hour - 12
          : (dateTime.hour == 0 ? 12 : dateTime.hour);
      final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';
      final min = dateTime.minute.toString().padLeft(2, '0');
      return '${dateTime.day} $month ${dateTime.year} - $hour:$min $amPm';
    } catch (_) {
      return dateString;
    }
  }

  Color _getTagColor(int index, String status) {
    if (index == 0) return Colors.green;
    if (index == 1) return const Color(0xFF2E5BFF);
    return AppColors.grey500;
  }

  String _getTagText(int index, String status) {
    if (index == 0) return 'Lowest';
    if (index == 1) return '2nd Lowest';
    return 'Viewed';
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      borderRadius: 8.r,
      border: Border.all(color: AppColors.grey200),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grey200,
                ),
                child: Icon(Icons.person, color: AppColors.grey500, size: 24.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
                    Text(
                      bid.contractorName,
                      style: AppTextStyles.font16SemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${bid.amount} EGP',
                      style: AppTextStyles.font16SemiBold.copyWith(
                        color: AppColors.primary700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14.r, color: AppColors.grey500),
                        SizedBox(width: 4.w),
                        Text(
                          '${bid.durationDays} Days',
                          style: AppTextStyles.font12MediumGrey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getTagColor(index, bid.status),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  _getTagText(index, bid.status),
                  style: AppTextStyles.font12MediumGrey.copyWith(
                    color: AppColors.white100,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            _formatDate(bid.date),
            style: AppTextStyles.font12MediumGrey,
          ),
        ],
      ),
    );
  }
}
