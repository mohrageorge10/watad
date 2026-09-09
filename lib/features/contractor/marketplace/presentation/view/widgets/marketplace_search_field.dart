import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class MarketplaceSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String hintText;

  const MarketplaceSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
    this.hintText = 'Search projects...',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
          width: 1.w,
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF1D1D1F),
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF8E8E93),
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: const Color(0xFF8E8E93),
              size: 20.r,
            ),
            suffixIcon: controller != null && controller!.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 18.r,
                      color: const Color(0xFF8E8E93),
                    ),
                    onPressed: () {
                      controller!.clear();
                      onClear?.call();
                    },
                  )
                : null,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
        ),
      ),
    );
  }
}
