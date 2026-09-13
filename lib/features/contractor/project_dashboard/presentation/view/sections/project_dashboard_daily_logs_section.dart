import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/project_dashboard/domain/entities/contractor_project_dashboard_entity.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/view/widgets/daily_log_item_widget.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/view/widgets/dashed_add_log_button_widget.dart';

class ProjectDashboardDailyLogsSection extends StatelessWidget {
  final List<DailyLogEntity> dailyLogs;
  final VoidCallback? onViewAllTap;
  final VoidCallback? onAddLogTap;
  final ValueChanged<DailyLogEntity>? onLogTap;

  const ProjectDashboardDailyLogsSection({
    super.key,
    required this.dailyLogs,
    this.onViewAllTap,
    this.onAddLogTap,
    this.onLogTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header: Daily Logs + View All →
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Logs',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1D1D1F),
              ),
            ),
            GestureDetector(
              onTap: onViewAllTap,
              child: Text(
                'View All →',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E3A8A),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // 2. Horizontal List: AI Verified Photo Logs + Add Button
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              // Log Items
              ...dailyLogs.map(
                (log) => Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: DailyLogItemWidget(
                    log: log,
                    onTap: onLogTap != null ? () => onLogTap!(log) : null,
                  ),
                ),
              ),

              // Add Log Button (Dashed box with +)
              DashedAddLogButtonWidget(
                onTap: onAddLogTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
