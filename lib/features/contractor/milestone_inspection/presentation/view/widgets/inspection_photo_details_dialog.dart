import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/entities/milestone_inspection_details_entity.dart';

class InspectionPhotoDetailsDialog extends StatelessWidget {
  final InspectionGalleryItemEntity item;

  const InspectionPhotoDetailsDialog({
    super.key,
    required this.item,
  });

  static Future<void> show(
    BuildContext context, {
    required InspectionGalleryItemEntity item,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (_) => InspectionPhotoDetailsDialog(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDefect =
        item.badgeType == InspectionLogBadgeType.defectDetected;
    final Color statusColor =
        isDefect ? const Color(0xFFDC2626) : const Color(0xFF00A859);
    final Color statusBg =
        isDefect ? const Color(0xFFFEE2E2) : const Color(0xFFE8F8F0);

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Photo Header with Status Badge & Close Button
            Stack(
              children: [
                // Large Image Preview
                Container(
                  height: 200.h,
                  width: double.infinity,
                  color: const Color(0xFF0F172A),
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const AppShimmerBox(
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: 0,
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFF1E293B),
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: Colors.white54,
                          size: 40.r,
                        ),
                      ),
                    ),
                  ),
                ),

                // Top Gradient for contrast
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 60.h,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Status Badge Overlay
                Positioned(
                  top: 12.h,
                  left: 12.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      item.badgeText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Close Icon Button
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 18.r,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 2. Details Content
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Date/Location Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isDefect ? 'Defect Inspection' : 'Verified Site Log',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          item.dateFormatted,
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (item.location != null) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 13.r,
                          color: const Color(0xFF94A3B8),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          item.location!,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],

                  SizedBox(height: 14.h),

                  // 3. Inspection Verdict Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isDefect
                            ? const Color(0xFFFCA5A5)
                            : const Color(0xFFB5E8CE),
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              isDefect
                                  ? Icons.error_outline_rounded
                                  : Icons.verified_rounded,
                              color: statusColor,
                              size: 18.r,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              isDefect
                                  ? (item.defectType ?? 'Structural Defect')
                                  : 'Quality Standards Approved',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: statusColor,
                              ),
                            ),
                            const Spacer(),
                            if (item.severity != null)
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 2.h),
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  item.severity!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (item.analysisVerdict != null) ...[
                          SizedBox(height: 8.h),
                          Text(
                            item.analysisVerdict!,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: const Color(0xFF334155),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // 4. Stats Row (Confidence, Type/Status)
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildMetricItem(
                            label: 'CONFIDENCE',
                            value: item.confidence ?? '95%',
                            color: AppColors.primary,
                          ),
                        ),
                        Container(
                          width: 1.w,
                          height: 28.h,
                          color: const Color(0xFFE2E8F0),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: _buildMetricItem(
                              label: isDefect ? 'SEVERITY' : 'VERDICT',
                              value: isDefect
                                  ? (item.severity ?? 'Requires Review')
                                  : 'ISO Compliant',
                              color: isDefect
                                  ? const Color(0xFFDC2626)
                                  : const Color(0xFF00A859),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 5. Recommendation Box if available
                  if (item.recommendation != null) ...[
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0xFFFDE68A),
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.lightbulb_outline_rounded,
                            color: const Color(0xFFD97706),
                            size: 16.r,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Recommendation / Action',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  item.recommendation!,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: const Color(0xFF92400E),
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: 18.h),

                  // 6. Action Button: Close
                  SizedBox(
                    width: double.infinity,
                    height: 44.h,
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 9.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF94A3B8),
            letterSpacing: 0.3,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
