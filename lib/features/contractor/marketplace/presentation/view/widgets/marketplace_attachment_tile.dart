import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class MarketplaceAttachmentTile extends StatelessWidget {
  final String title;
  final String size;
  final IconData leadingIcon;
  final Color leadingColor;
  final IconData trailingIcon;
  final VoidCallback? onTap;
  final VoidCallback? onDownloadTap;

  const MarketplaceAttachmentTile({
    super.key,
    required this.title,
    required this.size,
    this.leadingIcon = Icons.picture_as_pdf_rounded,
    this.leadingColor = const Color(0xFFFF3B30),
    this.trailingIcon = Icons.file_download_outlined,
    this.onTap,
    this.onDownloadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1.w,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? onDownloadTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                // Leading Red PDF Icon
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: leadingColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    leadingIcon,
                    color: leadingColor,
                    size: 20.r,
                  ),
                ),
                SizedBox(width: 12.w),

                // Title and Size
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        size,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF8E8E93),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // Trailing Download Action
                IconButton(
                  onPressed: onDownloadTap ?? onTap,
                  icon: Icon(
                    trailingIcon,
                    color: const Color(0xFF8E8E93),
                    size: 20.r,
                  ),
                  splashRadius: 20.r,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
