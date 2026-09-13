import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import '../../domain/entities/notification_item.dart';

class AlertCard extends StatelessWidget {
  final NotificationItem alert;

  const AlertCard({super.key, required this.alert});

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.alert:
      case NotificationType.warning:
        return Icons.warning_amber_rounded;
      case NotificationType.info:
        return Icons.info_outline_rounded;
      case NotificationType.actionRequired:
        return Icons.check_circle_outline_rounded;
    }
  }

  Color _getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.alert:
        return AppColors.alert; // Red
      case NotificationType.warning:
        return AppColors.icon; // Yellow/Orange
      case NotificationType.info:
        return AppColors.primary; // Blue
      case NotificationType.actionRequired:
        return AppColors.accept; // Green
    }
  }

  String _getTypeLabel(NotificationType type) {
    switch (type) {
      case NotificationType.alert:
        return "Alert";
      case NotificationType.warning:
        return "Warning";
      case NotificationType.info:
        return "Info";
      case NotificationType.actionRequired:
        return "Action Required"; 
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final isToday = date.year == now.year && date.month == now.month && date.day == now.day;
    final isYesterday = date.year == now.year && date.month == now.month && date.day == now.day - 1;
    
    final timeStr = DateFormat('hh:mm a').format(date);
    if (isToday) {
      return 'Today, $timeStr';
    } else if (isYesterday) {
      return 'Yesterday, $timeStr';
    } else {
      return '${DateFormat('dd MMM yyyy').format(date)} – $timeStr';
    }
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = _getColorForType(alert.type);
    final typeLabel = _getTypeLabel(alert.type);

    return GestureDetector(
      onTap: () {
        if (alert.actionUrl != null && alert.actionUrl!.contains('/change-orders/')) {
          final parts = alert.actionUrl!.split('/change-orders/');
          if (parts.length > 1) {
            final id = parts[1];
            context.push(AppRoutes.changeOrderDetails, extra: {
              'id': id,
              'isPending': true, // Alerts usually require review/action
            });
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: alert.isRead ? AppColors.white100 : AppColors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
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
                      if (alert.message.isNotEmpty) SizedBox(height: 4.h),
                      if (alert.message.isNotEmpty)
                        Text(
                          alert.message,
                          style: AppTextStyles.font12MediumGrey.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                      SizedBox(height: 8.h),
                      Text(
                        _formatDate(alert.createdAt),
                        style: AppTextStyles.font12MediumGrey.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!alert.isRead)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: AppColors.alert,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

