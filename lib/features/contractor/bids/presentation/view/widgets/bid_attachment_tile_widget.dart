import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';

class BidAttachmentTileWidget extends StatelessWidget {
  final String title;
  final String size;
  final VoidCallback? onDownloadTap;

  const BidAttachmentTileWidget({
    super.key,
    required this.title,
    required this.size,
    this.onDownloadTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onDownloadTap ??
          () {
            AppToast.showInfo(context, 'Downloading $title...');
          },
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            // Solid Red PDF Box
            Container(
              width: 38.r,
              height: 38.r,
              decoration: BoxDecoration(
                color: const Color(0xFFFF3B30),
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'PDF',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(width: 12.w),

            // Title & Size
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

            // Trailing Download Icon
            IconButton(
              onPressed: onDownloadTap ??
                  () {
                    AppToast.showInfo(context, 'Downloading $title...');
                  },
              icon: Icon(
                Icons.file_download_outlined,
                color: const Color(0xFF8E8E93),
                size: 22.r,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
