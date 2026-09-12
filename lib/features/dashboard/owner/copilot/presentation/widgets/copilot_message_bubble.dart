import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import '../../domain/entities/copilot_message.dart';
import 'package:intl/intl.dart';

class CopilotMessageBubble extends StatelessWidget {
  final CopilotMessage message;

  const CopilotMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) ...[
                Container(
                  width: 32.w,
                  height: 32.h,
                  margin: EdgeInsets.only(right: 8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    Icons.smart_toy_outlined,
                    size: 18.w,
                    color: AppColors.primary,
                  ),
                ),
              ],
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.primary : AppColors.white100,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                      bottomLeft: Radius.circular(isUser ? 16.r : 4.r),
                      bottomRight: Radius.circular(isUser ? 4.r : 16.r),
                    ),
                    boxShadow: isUser
                        ? []
                        : [
                            BoxShadow(
                              color: AppColors.black100.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                  ),
                  child: Text(
                    message.text,
                    style: AppTextStyles.font14Regular.copyWith(
                      color: isUser ? AppColors.white100 : AppColors.black100,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(
                left: isUser ? 0 : 40.w, right: isUser ? 8.w : 0),
            child: Text(
              DateFormat('hh:mm a').format(message.timestamp),
              style: AppTextStyles.font12RegularGrey.copyWith(
                color: AppColors.grey500,
                fontSize: 10.sp,
              ),
            ),
          ),
          if (!isUser && message.sources.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 4.h,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Sources:',
                    style: AppTextStyles.font12RegularGrey.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                  ...message.sources.map(
                    (source) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.secondBackground,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.grey300),
                      ),
                      child: Text(
                        source,
                        style: AppTextStyles.font12RegularGrey.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
