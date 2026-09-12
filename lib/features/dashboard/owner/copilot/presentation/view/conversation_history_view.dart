import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/core/shared/widgets/app_text_field.dart';
import '../widgets/conversation_history_item.dart';

class ConversationHistoryView extends StatelessWidget {
  final VoidCallback onNewSession;

  const ConversationHistoryView({super.key, required this.onNewSession});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black100.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Conversation History',
                  style: AppTextStyles.font18SemiBoldDark.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.grey500),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Start New Session Button
                  GestureDetector(
                    onTap: onNewSession,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: AppColors.white100, size: 20.w),
                          SizedBox(width: 8.w),
                          Text(
                            'Start New Session',
                            style: AppTextStyles.btnWhite600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  
                  // Search Field
                  AppTextField(
                    hintText: 'Search past conversations...',
                    prefixIcon: Icon(Icons.search, color: AppColors.grey500),
                  ),
                  SizedBox(height: 24.h),

                  // Mock History List
                  _buildSectionHeader('TODAY'),
                  const ConversationHistoryItem(
                    title: 'Concrete Pouring Inquiries',
                    messageCount: 12,
                    timeText: '2h ago',
                  ),
                  const ConversationHistoryItem(
                    title: 'Foundation Milestone Budget',
                    messageCount: 8,
                    timeText: '4h ago',
                  ),
                  SizedBox(height: 16.h),

                  _buildSectionHeader('YESTERDAY'),
                  const ConversationHistoryItem(
                    title: 'Site Inspection Questions',
                    messageCount: 6,
                    timeText: 'Yesterday',
                  ),
                  const ConversationHistoryItem(
                    title: 'Material Specifications',
                    messageCount: 6,
                    timeText: 'Yesterday',
                  ),
                  SizedBox(height: 16.h),

                  _buildSectionHeader('PREVIOUS 7 DAYS'),
                  const ConversationHistoryItem(
                    title: 'Project Timeline Update',
                    messageCount: 11,
                    timeText: 'May 16',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 4.w),
      child: Text(
        title,
        style: AppTextStyles.font12RegularGrey.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.grey500,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
