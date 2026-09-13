import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/entities/milestone_inspection_details_entity.dart';

class MilestoneInspectionHeaderSection extends StatelessWidget {
  final MilestoneInspectionDetailsEntity details;

  const MilestoneInspectionHeaderSection({
    super.key,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    final int progressPercentInt = (details.progressPercent * 100).round();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Row (Icon + Title & Subtitle + Circular Progress 100%)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEFFE),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.receipt_long_outlined,
                  color: const Color(0xFF1E3A8A),
                  size: 24.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1D1D1F),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      details.phaseSubtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF2563EB),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              // Circular progress badge (e.g. 100%)
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 44.r,
                    height: 44.r,
                    child: CircularProgressIndicator(
                      value: details.progressPercent.clamp(0.0, 1.0),
                      strokeWidth: 3.5,
                      backgroundColor: const Color(0xFFE5E5EA),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF1E3A8A),
                      ),
                    ),
                  ),
                  Text(
                    '$progressPercentInt%',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E3A8A),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // 2. Phase Progress Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phase Progress',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E3A8A),
                ),
              ),
              Text(
                '$progressPercentInt%',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E3A8A),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: details.progressPercent.clamp(0.0, 1.0),
              minHeight: 6.h,
              backgroundColor: const Color(0xFFE5E5EA),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF1E3A8A),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // 3. Stats Row (Site Logs, Start Date, Expected End)
          Row(
            children: [
              // 1. Site Logs
              Expanded(
                child: _buildStatItem(
                  icon: Icons.assignment_outlined,
                  topText: details.siteLogsCount.toString(),
                  bottomText: 'Site Logs',
                  isTopBold: true,
                ),
              ),

              Container(
                width: 1.w,
                height: 36.h,
                color: const Color(0xFFF2F2F7),
              ),

              // 2. Start Date
              Expanded(
                child: _buildStatItem(
                  icon: Icons.calendar_today_outlined,
                  topText: 'Start Date',
                  bottomText: details.startDateFormatted,
                  isTopBold: false,
                ),
              ),

              Container(
                width: 1.w,
                height: 36.h,
                color: const Color(0xFFF2F2F7),
              ),

              // 3. Expected End
              Expanded(
                child: _buildStatItem(
                  icon: Icons.calendar_today_outlined,
                  topText: 'Expected End',
                  bottomText: details.expectedEndDateFormatted,
                  isTopBold: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String topText,
    required String bottomText,
    required bool isTopBold,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 18.r,
          color: const Color(0xFF1E3A8A),
        ),
        SizedBox(height: 6.h),
        Text(
          topText,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isTopBold ? 14.sp : 10.sp,
            fontWeight: isTopBold ? FontWeight.bold : FontWeight.w500,
            color: isTopBold ? const Color(0xFF1D1D1F) : const Color(0xFF8E8E93),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          bottomText,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isTopBold ? 10.sp : 12.sp,
            fontWeight: isTopBold ? FontWeight.w500 : FontWeight.bold,
            color: isTopBold ? const Color(0xFF8E8E93) : const Color(0xFF1D1D1F),
          ),
        ),
      ],
    );
  }
}
