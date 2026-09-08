import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/presentation/view/widgets/portfolio_status_badge.dart';

class PortfolioProjectCard extends StatelessWidget {
  final PortfolioProjectItemModel project;
  final VoidCallback? onTap;
  final VoidCallback? onViewDetailsTap;

  const PortfolioProjectCard({
    super.key,
    required this.project,
    this.onTap,
    this.onViewDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? onViewDetailsTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Leading Rounded-Square Image (~80x80)
                _buildProjectImage(),

                SizedBox(width: 12.w),

                // Trailing Details Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Title (Expanded) & Status Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              project.title,
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          PortfolioStatusBadge(
                            text: project.badgeText,
                            type: project.badgeType,
                          ),
                        ],
                      ),

                      SizedBox(height: 6.h),

                      // Location text (dark grey)
                      Text(
                        project.location,
                        style: TextStyle(
                          color: const Color(0xFF4D5461),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 4.h),

                      // Price text (dark grey / bold)
                      Text(
                        project.price,
                        style: TextStyle(
                          color: const Color(0xFF1D1D1F),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 4.h),

                      // Date text (light grey)
                      Text(
                        project.date,
                        style: TextStyle(
                          color: const Color(0xFF8E8E93),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 4.h),

                      // Bottom right: View Details >
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: onViewDetailsTap ?? onTap,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View Details',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.primary,
                                size: 16.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 80.w,
        height: 80.w,
        color: const Color(0xFFEDEFFE),
        child: project.image.startsWith('http')
            ? Image.network(
                project.image,
                width: 80.w,
                height: 80.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _fallbackImagePlaceholder(),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 80.w,
                    height: 80.w,
                    color: const Color(0xFFF3F4F6),
                    child: Center(
                      child: SizedBox(
                        width: 18.r,
                        height: 18.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  );
                },
              )
            : _fallbackImagePlaceholder(),
      ),
    );
  }

  Widget _fallbackImagePlaceholder() {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEFFE),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Icon(
          Icons.apartment_rounded,
          color: AppColors.primary,
          size: 32.r,
        ),
      ),
    );
  }
}
