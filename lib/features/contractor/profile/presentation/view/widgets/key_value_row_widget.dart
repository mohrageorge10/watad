import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeyValueRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final EdgeInsetsGeometry? padding;

  const KeyValueRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value.trim().isNotEmpty;

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF6B7280),
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              hasValue ? value : 'Not provided',
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 13.sp,
                color: hasValue
                    ? const Color(0xFF1D1D1F)
                    : const Color(0xFF8E8E93),
                fontWeight:
                    hasValue ? FontWeight.w700 : FontWeight.w500,
                fontStyle:
                    hasValue ? FontStyle.normal : FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
