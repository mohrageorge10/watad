import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class ContractProjectContextCard extends StatelessWidget {
  final String subtitle;
  final String projectName;
  final String contractValue;
  final String duration;
  final String startDate;
  final String endDate;

  const ContractProjectContextCard({
    super.key,
    this.subtitle = 'PROJECT CONTEXT',
    required this.projectName,
    required this.contractValue,
    required this.duration,
    required this.startDate,
    required this.endDate,
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
          // Subtitle
          Text(
            subtitle.toUpperCase(),
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: 4.h),

          // Project Name
          Text(
            projectName,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 24.h),

          // 2x2 Grid
          // Row 1: Contract Value & Duration
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildMetricItem(
                  label: 'Contract Value',
                  value: contractValue,
                  valueColor: AppColors.primary,
                  isHighlight: true,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildMetricItem(
                  label: 'Duration',
                  value: duration,
                  valueColor: AppColors.primary,
                  isHighlight: true,
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Row 2: Start Date & End Date
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildMetricItem(
                  label: 'Start Date',
                  value: startDate,
                  hasCalendarIcon: true,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildMetricItem(
                  label: 'End Date',
                  value: endDate,
                  hasCalendarIcon: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    Color? valueColor,
    bool isHighlight = false,
    bool hasCalendarIcon = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF8E8E93),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (hasCalendarIcon) ...[
              Icon(
                Icons.calendar_today_outlined,
                color: AppColors.primary,
                size: 16.r,
              ),
              SizedBox(width: 6.w),
            ],
            Flexible(
              child: Text(
                value,
                style: TextStyle(
                  color: valueColor ?? const Color(0xFF1D1D1F),
                  fontSize: isHighlight ? 16.sp : 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
