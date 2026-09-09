import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class AppConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color? iconColor;
  final Color? iconBgColor;
  final String cancelText;
  final String confirmText;
  final Color? confirmButtonColor;

  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.iconColor,
    this.iconBgColor,
    this.cancelText = 'Cancel',
    this.confirmText = 'Confirm',
    this.confirmButtonColor,
  });

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required IconData icon,
    Color? iconColor,
    Color? iconBgColor,
    String cancelText = 'Cancel',
    String confirmText = 'Confirm',
    Color? confirmButtonColor,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AppConfirmationDialog(
        title: title,
        message: message,
        icon: icon,
        iconColor: iconColor,
        iconBgColor: iconBgColor,
        cancelText: cancelText,
        confirmText: confirmText,
        confirmButtonColor: confirmButtonColor,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? AppColors.primary;
    final effectiveIconBgColor =
        iconBgColor ?? effectiveIconColor.withValues(alpha: 0.1);
    final effectiveConfirmColor = confirmButtonColor ?? AppColors.primary;

    return AlertDialog(
      backgroundColor: AppColors.white100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      contentPadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 14.h),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: effectiveIconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: effectiveIconColor,
              size: 32.r,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D1D1F),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF6B7280),
              height: 1.45,
            ),
          ),
        ],
      ),
      actionsPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
      actions: [
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF6B7280),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  cancelText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: effectiveConfirmColor,
                  foregroundColor: AppColors.white100,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  confirmText,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
