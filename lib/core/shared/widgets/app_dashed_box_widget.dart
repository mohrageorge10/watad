import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class AppDashedBoxWidget extends StatelessWidget {
  final Widget? child;
  final String? text;
  final IconData? icon;
  final VoidCallback? onTap;
  final Color? color;
  final double? width;
  final double? height;
  final double? strokeWidth;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double dashWidth;
  final double dashSpace;

  const AppDashedBoxWidget({
    super.key,
    this.child,
    this.text,
    this.icon,
    this.onTap,
    this.color,
    this.width,
    this.height,
    this.strokeWidth,
    this.borderRadius,
    this.padding,
    this.dashWidth = 4.0,
    this.dashSpace = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.primary;
    final effectiveRadius = borderRadius ?? 12.r;
    final effectiveStroke = strokeWidth ?? 1.2;

    Widget content = child ??
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: effectiveColor, size: 18.r),
              if (text != null) SizedBox(width: 6.w),
            ],
            if (text != null)
              Text(
                text!,
                style: TextStyle(
                  color: effectiveColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(effectiveRadius),
      child: CustomPaint(
        painter: _AppDashedRectPainter(
          color: effectiveColor,
          strokeWidth: effectiveStroke,
          radius: effectiveRadius,
          dashWidth: dashWidth,
          dashSpace: dashSpace,
        ),
        child: Container(
          width: width,
          height: height,
          padding: padding ??
              (width == null && height == null
                  ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h)
                  : EdgeInsets.zero),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(effectiveRadius),
            color: Colors.transparent,
          ),
          child: content,
        ),
      ),
    );
  }
}

class _AppDashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;
  final double dashWidth;
  final double dashSpace;

  _AppDashedRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final length = (distance + dashWidth < metric.length)
            ? dashWidth
            : metric.length - distance;
        final extractPath = metric.extractPath(distance, distance + length);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_AppDashedRectPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      radius != oldDelegate.radius ||
      dashWidth != oldDelegate.dashWidth ||
      dashSpace != oldDelegate.dashSpace;
}
