import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/copilot/data/models/chat_message_dto.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessageDto message;

  const ChatMessageWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: isUser ? Colors.blue.shade100 : Colors.grey.shade200,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
              bottomLeft: isUser ? Radius.circular(16.r) : Radius.zero,
              bottomRight: isUser ? Radius.zero : Radius.circular(16.r),
            ),
          ),
          child: Text(
            message.content.isEmpty && !isUser ? 'Typing...' : message.content,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.black87,
              height: 1.4, // Avoid Arabic diacritics clipping
              fontFamily: 'Arial',
              fontFamilyFallback: const ['Roboto', 'Tahoma', 'sans-serif'],
            ),
          ),
        ),
      ),
    );
  }
}
