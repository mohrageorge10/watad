import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class AppAttachmentTileWidget extends StatelessWidget {
  final String title;
  final String size;
  final String? badgeText;
  final Color? badgeColor;
  final IconData? leadingIcon;
  final IconData trailingIcon;
  final bool hasBorder;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingTap;

  const AppAttachmentTileWidget({
    super.key,
    required this.title,
    required this.size,
    this.badgeText,
    this.badgeColor,
    this.leadingIcon,
    this.trailingIcon = Icons.file_download_outlined,
    this.hasBorder = true,
    this.onTap,
    this.onTrailingTap,
  });

  @override
  Widget build(BuildContext context) {
    final lower = title.toLowerCase();
    final isPdf = lower.endsWith('.pdf');
    final isDoc = lower.endsWith('.doc') || lower.endsWith('.docx');

    final effectiveBadgeColor = badgeColor ??
        (isPdf
            ? const Color(0xFFFF3B30)
            : isDoc
                ? const Color(0xFF2563EB)
                : AppColors.primary);

    final effectiveBadgeText = badgeText ??
        (isPdf
            ? 'PDF'
            : isDoc
                ? 'DOC'
                : 'FILE');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(14.r),
        border: hasBorder
            ? Border.all(
                color: const Color(0xFFE5E7EB),
                width: 1.w,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? onTrailingTap,
          borderRadius: BorderRadius.circular(14.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                // Leading Badge / Icon
                if (leadingIcon != null)
                  Container(
                    padding: EdgeInsets.all(7.r),
                    decoration: BoxDecoration(
                      color: effectiveBadgeColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      leadingIcon,
                      color: effectiveBadgeColor,
                      size: 20.r,
                    ),
                  )
                else
                  Container(
                    width: 38.r,
                    height: 38.r,
                    decoration: BoxDecoration(
                      color: effectiveBadgeColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      effectiveBadgeText,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                SizedBox(width: 12.w),

                // Title & Subtitle/Size
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

                // Trailing Action Button
                IconButton(
                  onPressed: onTrailingTap ?? onTap,
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
