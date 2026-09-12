import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

/// Standard, unified loading indicator for the entire Watad application.
class AppLoadingIndicator extends StatelessWidget {
  final double? size;
  final Color? color;
  final double? strokeWidth;

  const AppLoadingIndicator({
    super.key,
    this.size,
    this.color,
    this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    final double indicatorSize = size ?? 28.r;
    return Center(
      child: SizedBox(
        width: indicatorSize,
        height: indicatorSize,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth ?? 2.8,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}

/// Fullscreen or container-level loading widget with optional informative message.
class AppLoadingWidget extends StatelessWidget {
  final String? message;
  final Color? color;
  final double? size;

  const AppLoadingWidget({
    super.key,
    this.message,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppLoadingIndicator(
            size: size ?? 36.r,
            color: color,
          ),
          if (message != null && message!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF636366),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
