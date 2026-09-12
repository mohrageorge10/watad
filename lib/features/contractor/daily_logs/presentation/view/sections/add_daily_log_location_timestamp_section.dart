import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class AddDailyLogLocationTimestampSection extends StatelessWidget {
  final String locationCoords;
  final String timestamp;

  const AddDailyLogLocationTimestampSection({
    super.key,
    required this.locationCoords,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
          width: 1.w,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. Location Tagged
          Row(
            children: [
              Icon(
                Icons.near_me_outlined,
                color: const Color(0xFF1E3A8A),
                size: 16.r,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'LOCATION TAGGED',
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: const Color(0xFF8E8E93),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    locationCoords,
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1D1D1F),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // 2. Timestamp
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                color: const Color(0xFF1E3A8A),
                size: 16.r,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TIMESTAMP',
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: const Color(0xFF8E8E93),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    timestamp,
                    style: TextStyle(
                      fontSize: 11.sp,
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
