import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class ContractDigitalSignatureWidget extends StatelessWidget {
  final VoidCallback? onClear;
  final VoidCallback? onTapSignature;
  final bool hasSignature;
  final String disclaimerText;

  const ContractDigitalSignatureWidget({
    super.key,
    this.onClear,
    this.onTapSignature,
    this.hasSignature = false,
    this.disclaimerText =
        'Your signature will be added to the contract document before final submission.',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dashed Signature Area Box
          CustomPaint(
            painter: _DashedRectPainter(
              color: const Color(0xFFE5E5EA),
              strokeWidth: 1.5,
              dashLength: 6,
              dashGap: 4,
              borderRadius: 12.r,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFAFAFC),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Signature wave graphic & placeholder text
                  Expanded(
                    child: InkWell(
                      onTap: onTapSignature,
                      child: Row(
                        children: [
                          // Handwritten wave signature icon
                          CustomPaint(
                            size: Size(44.w, 24.h),
                            painter: _SignatureWavePainter(
                              color: const Color(0xFF1D1D1F),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Draw your signature here',
                              style: TextStyle(
                                color: const Color(0xFF8E8E93),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Clear button
                  OutlinedButton(
                    onPressed: onClear,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.primary,
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Clear',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Disclaimer row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Icon(
                  Icons.info_outline_rounded,
                  color: const Color(0xFF8E8E93),
                  size: 16.r,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  disclaimerText,
                  style: TextStyle(
                    color: const Color(0xFF8E8E93),
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Custom painter for rounded dashed rectangle
class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;
  final double borderRadius;

  _DashedRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashLength,
    required this.dashGap,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);
    final dashPath = Path();

    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final length = (distance + dashLength < metric.length)
            ? dashLength
            : metric.length - distance;
        dashPath.addPath(
          metric.extractPath(distance, distance + length),
          Offset.zero,
        );
        distance += dashLength + dashGap;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant _DashedRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.borderRadius != borderRadius;
  }
}

/// Custom painter for the signature wave lines matching the screenshot
class _SignatureWavePainter extends CustomPainter {
  final Color color;

  _SignatureWavePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    // Smooth wavy signature line mimicking handwritten stroke
    final h = size.height;
    final w = size.width;

    path.moveTo(w * 0.05, h * 0.65);
    path.cubicTo(w * 0.15, h * 0.6, w * 0.2, h * 0.2, w * 0.35, h * 0.3);
    path.cubicTo(w * 0.45, h * 0.4, w * 0.48, h * 0.8, w * 0.6, h * 0.55);
    path.cubicTo(w * 0.7, h * 0.3, w * 0.85, h * 0.45, w * 0.95, h * 0.6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SignatureWavePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
