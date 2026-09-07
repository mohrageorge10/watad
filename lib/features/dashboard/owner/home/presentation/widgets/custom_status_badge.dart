import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
// Removed mock data

class CustomStatusBadge extends StatelessWidget {
  final String status;

  const CustomStatusBadge({super.key, required this.status});

  Color get _badgeColor {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus.contains("progress")) return AppColors.accept;
    if (lowerStatus.contains("design")) return AppColors.icon;
    if (lowerStatus.contains("draft")) return AppColors.deactivation;
    if (lowerStatus.contains("active")) return AppColors.accept;
    return AppColors.accept; // Default to accept color so it's visible
  }

  String get _badgeText {
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _badgeColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        _badgeText,
        style: AppTextStyles.font10MediumWhite,
      ),
    );
  }
}
