import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class ConversationHistoryItem extends StatelessWidget {
  final String title;
  final int messageCount;
  final String timeText;

  const ConversationHistoryItem({
    super.key,
    required this.title,
    required this.messageCount,
    required this.timeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              color: AppColors.primary,
              size: 20.w,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font14SemiBoldDark.copyWith(
                    color: AppColors.black100,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      '$messageCount messages',
                      style: AppTextStyles.font12RegularGrey.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text(
                        '•',
                        style: AppTextStyles.font12RegularGrey.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                    ),
                    Text(
                      timeText,
                      style: AppTextStyles.font12RegularGrey.copyWith(
                        color: AppColors.grey500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: AppColors.grey500, size: 20.w),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
