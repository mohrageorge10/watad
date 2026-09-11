import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.colorHex,
    this.icon,
    this.isPill = true,
  });

  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final String? colorHex;
  final IconData? icon;
  final bool isPill;

  static Color _parseHex(String hex) {
    try {
      final buffer = StringBuffer();
      if (hex.length == 6 || hex.length == 7) buffer.write('ff');
      buffer.write(hex.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (_) {
      return AppColors.accept;
    }
  }

  Color _resolveBackgroundColor() {
    if (backgroundColor != null) return backgroundColor!;
    if (colorHex != null && colorHex!.isNotEmpty) return _parseHex(colorHex!);

    switch (text.toLowerCase().trim()) {
      case 'in progress':
      case 'completed':
      case 'accepted':
      case 'success':
        return AppColors.accept;
      case 'rejected':
      case 'alert':
      case 'declined':
        return AppColors.alert;
      case 'design phase':
      case 'viewed':
        return AppColors.icon;
      case 'draft':
      case 'pending':
      case 'pending review':
        return const Color(0xFFF59E0B); // Amber / Warning
      case 'feasibility calculated':
        return AppColors.primary;
      default:
        return AppColors.deactivation;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _resolveBackgroundColor();
    final effectiveTextColor = textColor ?? AppColors.white100;
    final borderRadius = isPill ? BorderRadius.circular(20.r) : BorderRadius.circular(8.r);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: effectiveTextColor,
              size: 13.r,
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            text,
            style: AppTextStyles.font10MediumWhite.copyWith(
              color: effectiveTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
