import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class EmptyCopilotStateWidget extends StatelessWidget {
  final VoidCallback onNewChat;

  const EmptyCopilotStateWidget({Key? key, required this.onNewChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: onNewChat,
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Text(
                  '+ New Chat',
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.1),
            ),
            child: Icon(
              Icons.smart_toy_outlined, // Robot with helmet metaphor
              size: 40.w,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'How can I help you with your project today?',
            style: AppTextStyles.font18SemiBoldDark.copyWith(
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 12.h),
          Text(
            'Ask about contracts, technical specifications, budget, or site progress.',
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.grey500,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ],
      ),
    );
  }
}
