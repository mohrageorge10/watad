import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/project_dashboard/domain/entities/contractor_project_dashboard_entity.dart';

class ProjectDashboardHeroCardSection extends StatelessWidget {
  final ContractorProjectDashboardEntity dashboard;

  const ProjectDashboardHeroCardSection({
    super.key,
    required this.dashboard,
  });

  @override
  Widget build(BuildContext context) {
    final specItems = <Widget>[];
    if (dashboard.landArea.isNotEmpty) {
      specItems.add(_buildSpecItem(
        icon: Icons.crop_square_rounded,
        label: 'Land Area',
        value: dashboard.landArea,
      ));
    }
    if (dashboard.floors.isNotEmpty) {
      specItems.add(_buildSpecItem(
        icon: Icons.layers_outlined,
        label: 'Floors',
        value: dashboard.floors,
      ));
    }
    if (dashboard.finishingLevel.isNotEmpty) {
      specItems.add(_buildSpecItem(
        icon: Icons.auto_awesome_outlined,
        label: 'Finishing Level',
        value: dashboard.finishingLevel,
      ));
    }

    final financeItems = <Widget>[];
    if (dashboard.contractValue.isNotEmpty) {
      financeItems.add(_buildFinanceItem(
        icon: Icons.payments_outlined,
        label: 'Contract Value',
        value: dashboard.contractValue,
      ));
    }
    if (dashboard.startDate.isNotEmpty) {
      financeItems.add(_buildFinanceItem(
        icon: Icons.calendar_today_outlined,
        label: 'Start Date',
        value: dashboard.startDate,
      ));
    }
    if (dashboard.endDate.isNotEmpty) {
      financeItems.add(_buildFinanceItem(
        label: 'End Date',
        value: dashboard.endDate,
      ));
    }

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
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top Image Banner with Active Badge
          Stack(
            children: [
              SizedBox(
                height: 180.h,
                width: double.infinity,
                child: dashboard.imageUrl.isNotEmpty
                    ? Image.network(
                        dashboard.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildImageFallback(),
                      )
                    : _buildImageFallback(),
              ),

              // Active Badge (Top Right)
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E3A8A),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    dashboard.status.isNotEmpty ? dashboard.status : 'Active',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 2. Card Content Details
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Location Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Building Icon Container
                    Container(
                      width: 44.r,
                      height: 44.r,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F7),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.apartment_rounded,
                          color: const Color(0xFF1E3A8A),
                          size: 24.r,
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // Title + Location + Code
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dashboard.title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1D1D1F),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            dashboard.location,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF8E8E93),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 12.r,
                                color: const Color(0xFF8E8E93),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                dashboard.projectCode,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: const Color(0xFF8E8E93),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                if (specItems.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  const Divider(height: 1, color: Color(0xFFF2F4F7)),
                  SizedBox(height: 14.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: specItems,
                  ),
                ],

                if (financeItems.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: financeItems,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: const Color(0xFF1E3A8A),
          size: 18.r,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: const Color(0xFF8E8E93),
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1D1D1F),
          ),
        ),
      ],
    );
  }

  Widget _buildFinanceItem({
    IconData? icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: const Color(0xFF1E3A8A),
                size: 12.r,
              ),
              SizedBox(width: 4.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF8E8E93),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1D1D1F),
          ),
        ),
      ],
    );
  }

  Widget _buildImageFallback() {
    return Container(
      color: const Color(0xFFEDEFFE),
      child: Center(
        child: Icon(
          Icons.villa_rounded,
          color: const Color(0xFF1E3A8A),
          size: 48.r,
        ),
      ),
    );
  }
}
