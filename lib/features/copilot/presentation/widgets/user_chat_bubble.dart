import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';

class UserChatBubble extends StatelessWidget {
  final ChatMessageDto message;

  const UserChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We don't have timestamp in ChatMessageDto for now, mocking to current time for UI
    final String timeString = DateFormat('hh:mm a').format(DateTime.now());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: TextDirection.rtl,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomRight: Radius.circular(4.r),
                  bottomLeft: Radius.circular(16.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message.content,
                    style: AppTextStyles.font14Regular.copyWith(
                      color: AppColors.white100,
                      height: 1.5,
                      fontFamily: 'Arial',
                      fontFamilyFallback: const ['Roboto', 'Tahoma', 'sans-serif'],
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        timeString,
                        style: AppTextStyles.font12RegularGrey.copyWith(
                          color: AppColors.white100.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.done_all,
                        size: 14.w,
                        color: AppColors.white100.withOpacity(0.9),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
