import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class ContractProjectSummaryCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final String statusText;
  final bool isSigned;

  const ContractProjectSummaryCard({
    super.key,
    required this.title,
    required this.location,
    required this.imageUrl,
    this.statusText = 'Signed',
    this.isSigned = true,
  });

  @override
  Widget build(BuildContext context) {
    const greenAccent = Color(0xFF00B368);

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
      padding: EdgeInsets.all(16.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading square image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              width: 56.r,
              height: 56.r,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(
                  color: const Color(0xFFE5E7EB),
                  child: Icon(
                    Icons.home_work_outlined,
                    color: const Color(0xFF9CA3AF),
                    size: 28.r,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Middle: Title and Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF1D1D1F),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: greenAccent,
                      size: 14.r,
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                          color: const Color(0xFF1D1D1F),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          // Trailing status indicator
          if (isSigned)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_rounded,
                  color: greenAccent,
                  size: 16.r,
                ),
                SizedBox(width: 4.w),
                Text(
                  statusText,
                  style: TextStyle(
                    color: greenAccent,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
