import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class CircularActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const CircularActionButton({
    super.key,
    required this.onTap,
    this.icon = Icons.arrow_forward_ios_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppColors.white100,
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}
