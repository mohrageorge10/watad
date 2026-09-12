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
          Text(
            value.trim().isNotEmpty ? value : 'Not provided',
            style: TextStyle(
              fontSize: 13.sp,
              color: value.trim().isNotEmpty
                  ? const Color(0xFF1D1D1F)
                  : const Color(0xFF8E8E93),
              fontWeight:
                  value.trim().isNotEmpty ? FontWeight.w700 : FontWeight.w500,
              fontStyle:
                  value.trim().isNotEmpty ? FontStyle.normal : FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
