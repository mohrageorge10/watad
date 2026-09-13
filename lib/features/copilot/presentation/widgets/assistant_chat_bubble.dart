import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';
import 'sources_badge_widget.dart';

class AssistantChatBubble extends StatelessWidget {
  final ChatMessageDto message;
  final bool isStreaming;

  const AssistantChatBubble({
    Key? key,
    required this.message,
    this.isStreaming = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String timeString = DateFormat('hh:mm a').format(DateTime.now());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            margin: EdgeInsets.only(left: 8.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withOpacity(0.1),
            ),
            child: Icon(
              Icons.smart_toy_outlined,
              size: 18.w,
              color: AppColors.primary,
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.white100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                  bottomLeft: Radius.circular(4.r),
                ),
                border: Border.all(color: AppColors.grey200, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black100.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isStreaming && message.content.isEmpty
                      ? SizedBox(
                          width: 24.w,
                          height: 12.h,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.w,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : Text(
                          message.content,
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.black100,
                            height: 1.6,
                            fontFamily: 'Arial',
                            fontFamilyFallback: const ['Roboto', 'Tahoma', 'sans-serif'],
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                  if (!isStreaming && message.content.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    const SourcesBadgeWidget(),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        timeString,
                        style: AppTextStyles.font12RegularGrey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
