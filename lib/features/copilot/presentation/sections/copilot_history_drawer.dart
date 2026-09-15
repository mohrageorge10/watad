import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class CopilotHistoryDrawer extends StatelessWidget {
  final VoidCallback onNewSession;
  
  const CopilotHistoryDrawer({Key? key, required this.onNewSession}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      color: AppColors.secondBackground,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: ElevatedButton(
                onPressed: onNewSession,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    Icon(Icons.add, color: AppColors.white100, size: 20.w),
                    SizedBox(width: 8.w),
                    Text(
                      'Start new session',
                      style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.white100),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search previous chats...',
                    hintStyle: AppTextStyles.font14Regular.copyWith(color: AppColors.grey500),
                    prefixIcon: Icon(Icons.search, color: AppColors.grey500),
                    filled: true,
                    fillColor: AppColors.white100,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: AppColors.grey200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: AppColors.grey200),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                children: [
                  _buildSectionTitle('Today'),
                  _buildHistoryCard('Villa contract inquiry', '12 messages', '2 hours ago'),
                  _buildHistoryCard('Concrete specifications', '4 messages', '5 hours ago'),
                  
                  SizedBox(height: 16.h),
                  _buildSectionTitle('Yesterday'),
                  _buildHistoryCard('Budget analysis', '20 messages', 'Yesterday'),
                  
                  SizedBox(height: 16.h),
                  _buildSectionTitle('Last 7 days'),
                  _buildHistoryCard('Weekly site updates', '8 messages', '3 days ago'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: AppTextStyles.font12RegularGrey.copyWith(
          color: AppColors.grey500,
          fontWeight: FontWeight.w600,
        ),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildHistoryCard(String title, String count, String time) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.chat_bubble_outline, color: AppColors.primary, size: 20.w),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.black100,
                    fontWeight: FontWeight.w600,
                  ),
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      count,
                      style: AppTextStyles.font12RegularGrey,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Text('•', style: AppTextStyles.font12RegularGrey),
                    ),
                    Text(
                      time,
                      style: AppTextStyles.font12RegularGrey,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.more_vert, color: AppColors.grey500, size: 20.w),
        ],
      ),
    );
  }
}
