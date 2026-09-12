import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/project_dashboard/domain/entities/contractor_project_dashboard_entity.dart';

class DailyLogItemWidget extends StatelessWidget {
  final DailyLogEntity log;
  final VoidCallback? onTap;

  const DailyLogItemWidget({
    super.key,
    required this.log,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80.w,
        height: 80.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: const Color(0xFFE5E5EA),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Thumbnail image
            if (log.imageUrl.isNotEmpty)
              Image.network(
                log.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildFallback(),
              )
            else
              _buildFallback(),

            // Bottom Green "✓ AI Verified" Badge
            if (log.isAiVerified)
              Positioned(
                bottom: 4.h,
                left: 4.w,
                right: 4.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00B368),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 9.r,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'AI Verified',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallback() {
    return Container(
      color: const Color(0xFFEDEFFE),
      child: Center(
        child: Icon(
          Icons.photo_outlined,
          color: const Color(0xFF1E3A8A),
          size: 24.r,
        ),
      ),
    );
  }
}
