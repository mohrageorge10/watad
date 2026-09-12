import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/project_dashboard/domain/entities/contractor_project_dashboard_entity.dart';

class ProjectDashboardActiveMilestoneCardSection extends StatelessWidget {
  final ActiveMilestoneEntity milestone;

  const ProjectDashboardActiveMilestoneCardSection({
    super.key,
    required this.milestone,
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
          // 1. Header: ACTIVE MILESTONE + Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: const Color(0xFF1E3A8A),
                    size: 16.r,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'ACTIVE MILESTONE',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: const Color(0xFF8E8E93),
                    ),
                  ),
                ],
              ),

              // Green "In Progress" Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B368),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  milestone.status.isNotEmpty ? milestone.status : 'In Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // 2. Milestone Title
          Text(
            milestone.title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1D1D1F),
            ),
          ),

          SizedBox(height: 14.h),

          // 3. Info Row: Target Date + Next Payment
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Target Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: const Color(0xFF8E8E93),
                        size: 13.r,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Target Date',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    milestone.targetDate,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1D1D1F),
                    ),
                  ),
                ],
              ),

              // Next Payment
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Next Payment',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: const Color(0xFF8E8E93),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    milestone.nextPayment,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1D1D1F),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
