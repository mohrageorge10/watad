import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class AddDailyLogProjectHeaderSection extends StatelessWidget {
  final String projectName;
  final String milestoneName;
  final String status;
  final String siteLocation;
  final String dateFormatted;
  final String? thumbnailUrl;

  const AddDailyLogProjectHeaderSection({
    super.key,
    required this.projectName,
    required this.milestoneName,
    required this.status,
    required this.siteLocation,
    required this.dateFormatted,
    this.thumbnailUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          // 1. Top Row: Thumbnail + Project Title/Milestone + In Progress Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  width: 50.r,
                  height: 50.r,
                  color: const Color(0xFFEDEFFE),
                  child: thumbnailUrl != null && thumbnailUrl!.isNotEmpty
                      ? Image.network(
                          thumbnailUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildFallback(),
                        )
                      : _buildFallback(),
                ),
              ),

              SizedBox(width: 12.w),

              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectName,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1D1D1F),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      milestoneName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF8E8E93),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              // Green "In Progress" Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B368),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),
          const Divider(height: 1, color: Color(0xFFF2F4F7)),
          SizedBox(height: 12.h),

          // 2. Bottom Row: Site Location + Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Site Location
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: const Color(0xFF1E3A8A),
                    size: 16.r,
                  ),
                  SizedBox(width: 6.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Site Location',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color(0xFF8E8E93),
                        ),
                      ),
                      Text(
                        siteLocation,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1D1D1F),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Date
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: const Color(0xFF1E3A8A),
                    size: 14.r,
                  ),
                  SizedBox(width: 6.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color(0xFF8E8E93),
                        ),
                      ),
                      Text(
                        dateFormatted,
                        style: TextStyle(
                          fontSize: 12.sp,
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
        ],
      ),
    );
  }

  Widget _buildFallback() {
    return Center(
      child: Icon(
        Icons.apartment_rounded,
        color: const Color(0xFF1E3A8A),
        size: 26.r,
      ),
    );
  }
}
