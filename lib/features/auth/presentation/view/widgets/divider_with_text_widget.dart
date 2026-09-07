import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerWithTextWidget extends StatelessWidget {
  const DividerWithTextWidget({
    super.key,
    required this.text,
    this.textColor,
    this.lineColor,
  });

  final String text;
  final Color? textColor;
  final Color? lineColor;

  @override
  Widget build(BuildContext context) {
    final effectiveLineColor = lineColor ?? const Color(0xFFC6C6C8);
    final effectiveTextColor = textColor ?? const Color(0xFF8E8E93);

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: effectiveLineColor,
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            text,
            style: TextStyle(
              color: effectiveTextColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: effectiveLineColor,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
