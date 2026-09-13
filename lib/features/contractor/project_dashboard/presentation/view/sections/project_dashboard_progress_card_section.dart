import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/view/widgets/circular_progress_gauge_widget.dart';

class ProjectDashboardProgressCardSection extends StatelessWidget {
  final int overallProgress;
  final int completedProgress;
  final int inProgressProgress;
  final int notStartedProgress;

  const ProjectDashboardProgressCardSection({
    super.key,
    required this.overallProgress,
    required this.completedProgress,
    required this.inProgressProgress,
    required this.notStartedProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'Overall Progress',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D1D1F),
            ),
          ),

          SizedBox(height: 16.h),

          // Content Row: Gauge on Left + Breakdown on Right
          Row(
            children: [
              // Circular Gauge
              CircularProgressGaugeWidget(
                percentage: overallProgress,
                size: 95,
                strokeWidth: 9,
              ),

              SizedBox(width: 24.w),

              // Legend Breakdown
              Expanded(
                child: Column(
                  children: [
                    _buildLegendRow(
                      dotColor: const Color(0xFF00B368),
                      title: 'Completed',
                      percentage: completedProgress,
                    ),
                    SizedBox(height: 10.h),
                    _buildLegendRow(
                      dotColor: const Color(0xFF1E3A8A),
                      title: 'In Progress',
                      percentage: inProgressProgress,
                    ),
                    SizedBox(height: 10.h),
                    _buildLegendRow(
                      dotColor: const Color(0xFFC7C7CC),
                      title: 'Not Started',
                      percentage: notStartedProgress,
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

  Widget _buildLegendRow({
    required Color dotColor,
    required String title,
    required int percentage,
  }) {
    return Row(
      children: [
        Container(
          width: 8.r,
          height: 8.r,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF636366),
            ),
          ),
        ),
        Text(
          '$percentage%',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1D1D1F),
          ),
        ),
      ],
    );
  }
}
