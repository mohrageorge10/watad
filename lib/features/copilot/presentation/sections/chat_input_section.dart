import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class ChatInputSection extends StatefulWidget {
  final bool isStreaming;
  final Function(String) onSend;

  const ChatInputSection({
    Key? key,
    required this.isStreaming,
    required this.onSend,
  }) : super(key: key);

  @override
  State<ChatInputSection> createState() => _ChatInputSectionState();
}

class _ChatInputSectionState extends State<ChatInputSection> {
  final TextEditingController _messageController = TextEditingController();

  // Arabic-only regex filter
  final RegExp _arabicRegex = RegExp(
    r"^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF0-9\s.,!؟?()\-_\n]+$",
  );

  void _onSendSubmitted() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final bool hasLatin = RegExp(r'[a-zA-Z]').hasMatch(text);
    final bool hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);

    if (hasLatin || !hasArabic) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Sorry, the chatbot only supports questions in Arabic.',
            textDirection: TextDirection.rtl,
            style: TextStyle(fontFamily: 'Arial'),
          ),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    widget.onSend(text);
    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        boxShadow: [
          BoxShadow(
            color: AppColors.black100.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F6F8),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            maxLines: 4,
                            minLines: 1,
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.rtl,
                            cursorColor: AppColors.primary,
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.black100,
                              fontFamily: 'Arial',
                              fontFamilyFallback: const ['Roboto', 'Tahoma', 'sans-serif'],
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(_arabicRegex),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Ask anything about this project...',
                              hintTextDirection: TextDirection.rtl,
                              hintStyle: AppTextStyles.font14Regular.copyWith(
                                color: AppColors.grey500,
                                fontFamily: 'Arial',
                                fontFamilyFallback: const ['Roboto', 'Tahoma', 'sans-serif'],
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.attach_file, color: AppColors.grey500, size: 24.w),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                InkWell(
                  onTap: widget.isStreaming ? null : _onSendSubmitted,
                  borderRadius: BorderRadius.circular(24.r),
                  child: Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isStreaming ? AppColors.grey200 : AppColors.primary,
                    ),
                    child: widget.isStreaming
                        ? Padding(
                            padding: EdgeInsets.all(12.w),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.w,
                              color: AppColors.primary,
                            ),
                          )
                        : Icon(Icons.send_rounded, color: AppColors.white100, size: 24.w),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: [
                Icon(Icons.shield_outlined, size: 14.w, color: AppColors.grey500),
                SizedBox(width: 4.w),
                Text(
                  'Copilot relies on project documents and the Egyptian building code.',
                  style: AppTextStyles.font12RegularGrey.copyWith(
                    color: AppColors.grey500,
                    fontFamily: 'Arial',
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
