import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class AiCrackInspectionDetailsSection extends StatelessWidget {
  final String confidence;
  final String location;
  final String crackType;
  final String severity;
  final String recommendation;

  const AiCrackInspectionDetailsSection({
    super.key,
    this.confidence = '92%',
    this.location = 'Wall - Section B',
    this.crackType = 'Structural Crack',
    this.severity = 'High Severity',
    this.recommendation = 'Monitor and repair within 7 days.',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Crack Detected Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row: Shield Icon + "Crack Detected" + "High Severity" Badge
              Row(
                children: [
                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFDBEAFE),
                        width: 1.w,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shield_outlined,
                        color: AppColors.primary,
                        size: 18.r,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Crack Detected',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      severity,
                      style: TextStyle(
                        color: const Color(0xFFDC2626),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              SizedBox(height: 14.h),

              // 3-Column Info Row (Confidence, Location, Type)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Confidence
                  Expanded(
                    child: _buildInfoItem(
                      label: 'CONFIDENCE',
                      value: confidence,
                      valueColor: AppColors.primary,
                    ),
                  ),
                  Container(
                    width: 1.w,
                    height: 36.h,
                    color: const Color(0xFFF1F5F9),
                  ),
                  // Location
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: _buildInfoItem(
                        label: 'LOCATION',
                        value: location,
                        valueColor: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  Container(
                    width: 1.w,
                    height: 36.h,
                    color: const Color(0xFFF1F5F9),
                  ),
                  // Type
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: _buildInfoItem(
                        label: 'TYPE',
                        value: crackType,
                        valueColor: const Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 14.h),

        // 2. Recommendation Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32.r,
                height: 32.r,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFDBEAFE),
                    width: 1.w,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.lightbulb_outline_rounded,
                    color: AppColors.primary,
                    size: 18.r,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommendation',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      recommendation,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF64748B),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF94A3B8),
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
