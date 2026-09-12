import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/daily_logs/presentation/view/sections/ai_crack_inspection_details_section.dart';
import 'package:watad/features/contractor/daily_logs/presentation/view/widgets/ai_scanning_image_preview_widget.dart';

class AiCrackInspectionScreen extends StatefulWidget {
  final String imagePath;
  final String? location;

  const AiCrackInspectionScreen({
    super.key,
    required this.imagePath,
    this.location,
  });

  @override
  State<AiCrackInspectionScreen> createState() =>
      _AiCrackInspectionScreenState();
}

class _AiCrackInspectionScreenState extends State<AiCrackInspectionScreen> {
  bool _isScanDone = false;

  void _handleAttachResult() {
    AppToast.showSuccess(
      context,
      'AI Crack Inspection attached to Daily Log',
    );
    context.pop(
      'Crack Detected (92% Confidence) • Structural Crack on ${widget.location ?? "Wall - Section B"}. Recommendation: Monitor and repair within 7 days.',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 22.r,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'AI Crack Inspection',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Futuristic AI Scanning Preview Widget
                    AiScanningImagePreviewWidget(
                      imagePath: widget.imagePath,
                      isScanning: true,
                      onScanStart: () {
                        if (mounted) {
                          setState(() {
                            _isScanDone = false;
                          });
                        }
                      },
                      onScanComplete: () {
                        if (mounted) {
                          setState(() {
                            _isScanDone = true;
                          });
                        }
                      },
                    ),

                    SizedBox(height: 16.h),

                    // 2. Inspection Result vs Live Analyzing State
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 450),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.08),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: _isScanDone
                          ? AiCrackInspectionDetailsSection(
                              key: const ValueKey('results_section'),
                              confidence: '92%',
                              location: widget.location ?? 'New Cairo, Cairo',
                              crackType: 'Structural Crack',
                              severity: 'High Severity',
                              recommendation:
                                  'Monitor and repair within 7 days.',
                            )
                          : Container(
                              key: const ValueKey('analyzing_section'),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 24.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.03),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 28.r,
                                    height: 28.r,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF1E3A8A),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Text(
                                    'AI Analyzing Photo...',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Scanning structural integrity, cracks and safety hazards.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Bottom Action Button: Attach to Daily Log
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: _isScanDone ? _handleAttachResult : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isScanDone
                        ? const Color(0xFF1E3A8A)
                        : const Color(0xFF94A3B8),
                    disabledBackgroundColor: const Color(0xFFCBD5E1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment_turned_in_outlined,
                        color: Colors.white,
                        size: 20.r,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        _isScanDone
                            ? 'Attach to Daily Log'
                            : 'AI Analyzing...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
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
