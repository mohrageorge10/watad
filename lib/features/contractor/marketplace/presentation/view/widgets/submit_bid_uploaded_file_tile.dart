import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class SubmitBidUploadedFileTile extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final VoidCallback? onRemove;

  const SubmitBidUploadedFileTile({
    super.key,
    required this.fileName,
    required this.fileSize,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final lowerName = fileName.toLowerCase();
    final isDoc = lowerName.endsWith('.doc') || lowerName.endsWith('.docx');
    final isPdf = lowerName.endsWith('.pdf');
    final badgeColor = isDoc
        ? const Color(0xFF2563EB)
        : (isPdf ? const Color(0xFFE53935) : AppColors.primary);
    final badgeText = isDoc ? 'DOC' : (isPdf ? 'PDF' : 'FILE');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE5E5EA),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          // File Icon Badge
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Text(
              badgeText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // File Title & Size
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  fileName,
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
                  fileSize,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF8E8E93),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          // Remove Button
          IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.close_rounded,
              color: const Color(0xFF8E8E93),
              size: 20.r,
            ),
            splashRadius: 20.r,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
