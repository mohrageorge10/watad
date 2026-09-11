import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class AppAttachmentTile extends StatelessWidget {
  const AppAttachmentTile({
    super.key,
    required this.title,
    this.size,
    this.fileExtension = 'PDF',
    this.onTap,
    this.onDownloadTap,
    this.trailingIcon = Icons.file_download_outlined,
    this.badgeColor = AppColors.alert,
  });

  final String title;
  final String? size;
  final String fileExtension;
  final VoidCallback? onTap;
  final VoidCallback? onDownloadTap;
  final IconData trailingIcon;
  final Color badgeColor;

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
                // Extension indicator badge
                Container(
                  width: 38.r,
                  height: 38.r,
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    fileExtension.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Title and size
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.font14SemiBoldDark.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      if (size != null && size!.isNotEmpty) ...[
                        SizedBox(height: 3.h),
                        Text(
                          size!,
                          style: AppTextStyles.font12RegularGrey,
                        ),
                      ],
                    ],
                  ),
                ),

                // Trailing Action
                if (onDownloadTap != null || onTap != null)
                  IconButton(
                    onPressed: onDownloadTap ?? onTap,
                    icon: Icon(
                      trailingIcon,
                      color: const Color(0xFF8E8E93),
                      size: 22.r,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 20.r,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
