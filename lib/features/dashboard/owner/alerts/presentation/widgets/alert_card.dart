import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import '../../domain/entities/alert_item.dart';

class AlertCard extends StatelessWidget {
  final AlertItem alert;

  const AlertCard({super.key, required this.alert});

  IconData _getIconForType(AlertType type) {
    switch (type) {
      case AlertType.critical:
      case AlertType.warning:
        return Icons.warning_amber_rounded;
      case AlertType.info:
        return Icons.info_outline_rounded;
      case AlertType.success:
        return Icons.check_circle_outline_rounded;
    }
  }

  Color _getColorForType(AlertType type) {
    switch (type) {
      case AlertType.critical:
        return AppColors.alert; // Red
      case AlertType.warning:
        return AppColors.icon; // Yellow/Orange
      case AlertType.info:
        return AppColors.primary; // Blue
      case AlertType.success:
        return AppColors.accept; // Green
    }
  }

  String _getTypeLabel(AlertType type) {
    switch (type) {
      case AlertType.critical:
        return "Critical";
      case AlertType.warning:
        return "Warning";
      case AlertType.info:
        return "Info";
      case AlertType.success:
        return ""; // Success alerts don't have a small label in the design
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = _getColorForType(alert.type);
    final typeLabel = _getTypeLabel(alert.type);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _getIconForType(alert.type),
            color: iconColor,
            size: 24.sp,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (typeLabel.isNotEmpty)
                  Text(
                    typeLabel,
                    style: AppTextStyles.font12RegularGrey.copyWith(
                      color: iconColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (typeLabel.isNotEmpty) SizedBox(height: 4.h),
                Text(
                  alert.title,
                  style: AppTextStyles.font14SemiBoldDark.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (alert.subtitle.isNotEmpty) SizedBox(height: 4.h),
                if (alert.subtitle.isNotEmpty)
                  Text(
                    alert.subtitle,
                    style: AppTextStyles.font12MediumGrey.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                SizedBox(height: 8.h),
                Text(
                  alert.dateText,
                  style: AppTextStyles.font12MediumGrey.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),
          ),
          if (alert.isUnread)
            Container(
              margin: EdgeInsets.only(top: 8.h),
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
