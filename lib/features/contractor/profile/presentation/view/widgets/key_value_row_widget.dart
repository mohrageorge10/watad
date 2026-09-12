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
            value,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF1D1D1F),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
