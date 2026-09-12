import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class CopilotMessageComposer extends StatefulWidget {
  final Function(String) onSend;
  final bool isSending;

  const CopilotMessageComposer({
    super.key,
    required this.onSend,
    this.isSending = false,
  });

  @override
  State<CopilotMessageComposer> createState() => _CopilotMessageComposerState();
}

class _CopilotMessageComposerState extends State<CopilotMessageComposer> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (_hasText != hasText) {
        setState(() {
          _hasText = hasText;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && !widget.isSending) {
      widget.onSend(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        boxShadow: [
          BoxShadow(
            color: AppColors.black100.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.attach_file, color: AppColors.grey500),
              onPressed: () {
                // Attach file action - placeholder
              },
            ),
            Expanded(
              child: Container(
                constraints: BoxConstraints(maxHeight: 120.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.secondBackground,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: AppColors.grey300),
                ),
                child: Scrollbar(
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    minLines: 1,
                    textInputAction: TextInputAction.newline,
                    style: AppTextStyles.font14Regular.copyWith(
                      color: AppColors.primary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Ask anything about this project...',
                      hintStyle: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.grey500,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: _hasText && !widget.isSending ? _handleSend : null,
              child: Container(
                width: 48.w,
                height: 48.w,
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _hasText && !widget.isSending
                      ? AppColors.primary
                      : AppColors.grey300,
                ),
                child: Center(
                  child: widget.isSending
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.w,
                            color: AppColors.white100,
                          ),
                        )
                      : Icon(
                          Icons.send_rounded,
                          color: AppColors.white100,
                          size: 20.w,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
