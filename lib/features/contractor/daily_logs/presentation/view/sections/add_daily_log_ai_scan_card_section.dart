import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/daily_logs/presentation/cubit/add_daily_log_state.dart';

class AddDailyLogAiScanCardSection extends StatelessWidget {
  final AiScanStatus aiScanStatus;
  final String? aiScanResult;
  final VoidCallback? onRunScanTap;

  const AddDailyLogAiScanCardSection({
    super.key,
    required this.aiScanStatus,
    this.aiScanResult,
    this.onRunScanTap,
  });

  @override
  Widget build(BuildContext context) {
    final isScanning = aiScanStatus == AiScanStatus.scanning;
    final isScanned = aiScanStatus == AiScanStatus.scanned;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F6FE),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFD6E4FC),
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Row: Magic icon + Title + AI POWERED badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dark Blue Icon Container with indicator
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                  child: Icon(
                    Icons.auto_fix_high_rounded,
                    color: Colors.white,
                    size: 20.r,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Title & AI POWERED badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6.w,
                      children: [
                        Text(
                          '✦ Scan with AI • Crack Detection',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1D1D1F),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E3A8A),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'AI POWERED',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Instantly analyze uploaded photos for structural cracks, hazards & work progress.',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF636366),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Scan Result banner if already scanned
          if (isScanned && aiScanResult != null && aiScanResult!.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F8F0),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFB5E8CE)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.verified_rounded,
                    color: const Color(0xFF00B368),
                    size: 16.r,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      aiScanResult!,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF00B368),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: 14.h),
          const Divider(height: 1, color: Color(0xFFD6E4FC)),
          SizedBox(height: 12.h),

          // 2. Footer Row: ISO Safety Check + Run Smart Scan Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ISO Safety Check
              Row(
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: const Color(0xFF1E3A8A),
                    size: 14.r,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'ISO 9001 Structural Safety Check',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E3A8A),
                    ),
                  ),
                ],
              ),

              // Run Smart Scan Button
              ElevatedButton(
                onPressed: isScanning ? null : onRunScanTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E3A8A),
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: isScanning
                    ? SizedBox(
                        width: 14.r,
                        height: 14.r,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isScanned ? 'Re-scan ↺' : 'Run Smart Scan →',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
