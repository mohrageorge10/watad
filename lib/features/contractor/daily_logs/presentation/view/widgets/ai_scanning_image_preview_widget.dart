import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiScanningImagePreviewWidget extends StatefulWidget {
  final String imagePath;
  final bool isScanning;
  final VoidCallback? onScanStart;
  final VoidCallback? onScanComplete;

  const AiScanningImagePreviewWidget({
    super.key,
    required this.imagePath,
    this.isScanning = true,
    this.onScanStart,
    this.onScanComplete,
  });

  @override
  State<AiScanningImagePreviewWidget> createState() =>
      _AiScanningImagePreviewWidgetState();
}

class _AiScanningImagePreviewWidgetState
    extends State<AiScanningImagePreviewWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scannerController;
  late final Animation<double> _laserAnimation;
  bool _scanFinished = false;

  @override
  void initState() {
    super.initState();
    _scanFinished = !widget.isScanning;
    _scannerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _laserAnimation = Tween<double>(begin: 0.05, end: 0.95).animate(
      CurvedAnimation(
        parent: _scannerController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.isScanning) {
      _startLaserSweepAndTimer();
    }
  }

  void _startLaserSweepAndTimer() {
    _scannerController.repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        _scannerController.stop();
        setState(() {
          _scanFinished = true;
        });
        widget.onScanComplete?.call();
      }
    });
  }

  void _triggerReScan() {
    setState(() {
      _scanFinished = false;
    });
    widget.onScanStart?.call();
    _startLaserSweepAndTimer();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Widget _buildImage() {
    final path = widget.imagePath;
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    final file = File(path);
    if (file.existsSync()) {
      return Image.file(
        file,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFF1E293B),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: Colors.white54,
          size: 48.r,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Base Image
            _buildImage(),

            // 2. Cyber HUD Hologram Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.45),
                  ],
                ),
              ),
            ),

            // 3. Grid / Corner Reticles HUD
            CustomPaint(
              painter: _HudCornerPainter(
                color: _scanFinished
                    ? const Color(0xFF00E676)
                    : const Color(0xFF38BDF8),
              ),
            ),

            // 4. Laser Scan Animation Line & Glow Beam
            if (!_scanFinished)
              AnimatedBuilder(
                animation: _laserAnimation,
                builder: (context, child) {
                  final positionFactor = _laserAnimation.value;
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final topPos = constraints.maxHeight * positionFactor;
                      return Stack(
                        children: [
                          // Laser Glow Trail
                          Positioned(
                            top: topPos - 30.h,
                            left: 0,
                            right: 0,
                            height: 60.h,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    const Color(0xFF00E676)
                                        .withValues(alpha: 0.25),
                                    const Color(0xFF00E676)
                                        .withValues(alpha: 0.6),
                                    const Color(0xFF00E676)
                                        .withValues(alpha: 0.25),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Bright Laser Blade Line
                          Positioned(
                            top: topPos,
                            left: 8.w,
                            right: 8.w,
                            height: 2.5.h,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00E676),
                                    blurRadius: 10.r,
                                    spreadRadius: 2.r,
                                  ),
                                  BoxShadow(
                                    color: const Color(0xFF38BDF8),
                                    blurRadius: 18.r,
                                    spreadRadius: 3.r,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

            // 5. Detected Crack Bounding Box & Target Highlight
            if (_scanFinished)
              Positioned(
                left: 95.w,
                top: 38.h,
                width: 140.w,
                height: 135.h,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Crack Detection Bounding Box
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                            color: const Color(0xFF00E676),
                            width: 2.w,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00E676)
                                  .withValues(alpha: 0.2),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),

                      // Elliptical Spotlight Glow on the Crack Center
                      Center(
                        child: Container(
                          width: 60.w,
                          height: 36.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.45),
                                blurRadius: 14,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Top Label: Crack 92% Badge
                      Positioned(
                        top: -12.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00E676),
                              borderRadius: BorderRadius.circular(6.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'Crack 92%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // 6. Scanning Indicator Badge (Top Left)
            Positioned(
              top: 10.h,
              left: 10.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: _scanFinished
                        ? const Color(0xFF00E676).withValues(alpha: 0.8)
                        : const Color(0xFF38BDF8).withValues(alpha: 0.8),
                    width: 1.w,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _scanFinished
                            ? const Color(0xFF00E676)
                            : const Color(0xFF38BDF8),
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      _scanFinished ? 'AI VERIFIED' : 'ANALYZING...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 7. Re-scan Button (Top Right)
            if (_scanFinished)
              Positioned(
                top: 10.h,
                right: 10.w,
                child: InkWell(
                  onTap: _triggerReScan,
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                          size: 13.r,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Re-scan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for futuristic corner reticle markings
class _HudCornerPainter extends CustomPainter {
  final Color color;

  _HudCornerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    const cornerLength = 16.0;
    const padding = 10.0;

    // Top-Left
    canvas.drawLine(
      const Offset(padding, padding + cornerLength),
      const Offset(padding, padding),
      paint,
    );
    canvas.drawLine(
      const Offset(padding, padding),
      const Offset(padding + cornerLength, padding),
      paint,
    );

    // Top-Right
    canvas.drawLine(
      Offset(size.width - padding - cornerLength, padding),
      Offset(size.width - padding, padding),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(size.width - padding, padding + cornerLength),
      paint,
    );

    // Bottom-Left
    canvas.drawLine(
      Offset(padding, size.height - padding - cornerLength),
      Offset(padding, size.height - padding),
      paint,
    );
    canvas.drawLine(
      Offset(padding, size.height - padding),
      Offset(padding + cornerLength, size.height - padding),
      paint,
    );

    // Bottom-Right
    canvas.drawLine(
      Offset(size.width - padding - cornerLength, size.height - padding),
      Offset(size.width - padding, size.height - padding),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - padding, size.height - padding),
      Offset(size.width - padding, size.height - padding - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _HudCornerPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
