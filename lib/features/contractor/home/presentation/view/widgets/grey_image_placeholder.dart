import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class GreyImagePlaceholder extends StatelessWidget {
  const GreyImagePlaceholder({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.iconSize,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 140.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB), // Soft neutral grey
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 0.5.w,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: AppColors.deactivation,
          size: (iconSize ?? 36).r,
        ),
      ),
    );
  }
}
