import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';

class MilestoneLogTimelineCardWidget extends StatelessWidget {
  final MilestoneLogItemEntity log;

  const MilestoneLogTimelineCardWidget({
    super.key,
    required this.log,
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
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Layout according to log type
          if (log.type == MilestoneLogType.dailyLog) ...[
            _buildDailyLogHeader(),
          ] else if (log.type == MilestoneLogType.qaQc) ...[
            _buildQaqcHeader(),
          ] else if (log.type == MilestoneLogType.safety) ...[
            _buildSafetyHeader(),
          ] else ...[
            _buildSystemHeader(),
          ],

          SizedBox(height: 10.h),

          // 2. Body / Description Layout
          if (log.type == MilestoneLogType.safety) ...[
            _buildSafetyWarningBox(),
          ] else ...[
            Text(
              log.description,
              style: TextStyle(
                fontSize: 12.sp,
                color: log.type == MilestoneLogType.system
                    ? const Color(0xFF8E8E93)
                    : const Color(0xFF1E3A8A),
                height: 1.35,
              ),
            ),
          ],

          // 3. Attached Images Row (if any)
          if (log.attachedImages.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Row(
              children: log.attachedImages.map((imgUrl) {
                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      width: 54.r,
                      height: 54.r,
                      color: const Color(0xFFE5E5EA),
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildFallbackThumbnail(),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDailyLogHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (log.thumbnail != null && log.thumbnail!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: 48.r,
              height: 48.r,
              color: const Color(0xFFE5E5EA),
              child: Image.network(
                log.thumbnail!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildFallbackThumbnail(),
              ),
            ),
          ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AI Confidence & Milestone Progress Row (Wrapped to avoid overflow)
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 6.w,
                runSpacing: 2.h,
                children: [
                  if (log.aiConfidence != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.r,
                          height: 6.r,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00B368),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          log.aiConfidence!,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00B368),
                          ),
                        ),
                      ],
                    ),
                  if (log.milestoneProgressPercent != null)
                    Text(
                      log.milestoneProgressPercent!,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF00B368),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                log.timeFormatted,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1D1D1F),
                ),
              ),
              Text(
                'by ${log.authorName} (${log.authorRole})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF8E8E93),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQaqcHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (log.thumbnail != null && log.thumbnail!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Container(
              width: 48.r,
              height: 48.r,
              color: const Color(0xFFE5E5EA),
              child: Image.network(
                log.thumbnail!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildFallbackThumbnail(),
              ),
            ),
          ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                log.timeFormatted,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1D1D1F),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'by ${log.authorName} (${log.authorRole})',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF8E8E93),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSafetyHeader() {
    return Row(
      children: [
        Icon(
          Icons.access_time_rounded,
          color: const Color(0xFFFFA000),
          size: 16.r,
        ),
        SizedBox(width: 6.w),
        Text(
          log.timeFormatted,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1D1D1F),
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            'by ${log.authorName} (${log.authorRole})',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF8E8E93),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSystemHeader() {
    return Row(
      children: [
        Icon(
          Icons.outlined_flag_rounded,
          color: const Color(0xFF1E3A8A),
          size: 16.r,
        ),
        SizedBox(width: 6.w),
        Text(
          log.timeFormatted,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1D1D1F),
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            'by ${log.authorName}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF8E8E93),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSafetyWarningBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3D6),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFFFD56B),
          width: 1.w,
        ),
      ),
      child: Text(
        log.description,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFB45309),
          height: 1.35,
        ),
      ),
    );
  }

  Widget _buildFallbackThumbnail() {
    return Container(
      color: const Color(0xFFEDEFFE),
      child: Center(
        child: Icon(
          Icons.photo_outlined,
          color: const Color(0xFF1E3A8A),
          size: 20.r,
        ),
      ),
    );
  }
}
