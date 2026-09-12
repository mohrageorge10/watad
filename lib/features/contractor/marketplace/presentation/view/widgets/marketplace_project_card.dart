import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';

class MarketplaceProjectCard extends StatelessWidget {
  final MarketplaceProjectEntity project;
  final VoidCallback? onTap;
  final VoidCallback? onViewDetailsTap;
  final VoidCallback? onBookmarkTap;

  const MarketplaceProjectCard({
    super.key,
    required this.project,
    this.onTap,
    this.onViewDetailsTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
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
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Right Indicators (Time tag & Bookmark)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F4F7),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        project.timePosted,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFF8E8E93),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: onBookmarkTap,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.all(2.r),
                        child: Icon(
                          project.isBookmarked
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: project.isBookmarked
                              ? AppColors.primary
                              : const Color(0xFF8E8E93),
                          size: 20.r,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Body: Leading square image + Expanded details column
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: 80.r,
                        height: 80.r,
                        color: const Color(0xFFEDEFFE),
                        child: _buildProjectImage(project.image),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            project.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1D1D1F),
                            ),
                          ),
                          SizedBox(height: 6.h),

                          // Location
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14.r,
                                color: const Color(0xFF4758E0),
                              ),
                              SizedBox(width: 4.w),
                              Expanded(
                                child: Text(
                                  project.location,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF6B7280),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),

                          // Specs Row (Land size and Scope)
                          Row(
                            children: [
                              // Land Spec
                              Icon(
                                Icons.crop_free_rounded,
                                size: 14.r,
                                color: const Color(0xFF4758E0),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Land: ',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: const Color(0xFF8E8E93),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                project.specs.land,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: const Color(0xFF1D1D1F),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 10.w),

                              // Scope Spec
                              Icon(
                                Icons.feed_outlined,
                                size: 14.r,
                                color: const Color(0xFF4758E0),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'Scope: ',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: const Color(0xFF8E8E93),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  project.specs.scope,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: const Color(0xFF1D1D1F),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Footer: Est. Budget + View Details filled button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.budgetLabel,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF8E8E93),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          project.budgetValue,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: onViewDetailsTap ?? onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white100,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white100,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectImage(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        width: 80.r,
        height: 80.r,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: SizedBox(
              width: 20.r,
              height: 20.r,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            ),
          );
        },
      );
    } else if (imagePath.isNotEmpty) {
      return Image.asset(
        imagePath,
        width: 80.r,
        height: 80.r,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: const Color(0xFFEDEFFE),
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
