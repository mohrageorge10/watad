import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_attachment_tile.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class ContractDocumentCard extends StatelessWidget {
  const ContractDocumentCard({
    super.key,
    required this.pdfUrl,
    this.fileName = 'contract_villa_newcairo.pdf',
    this.fileSize = '2.4 MB',
    this.onDownloadTap,
  });

  final String pdfUrl;
  final String fileName;
  final String fileSize;
  final VoidCallback? onDownloadTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.edit_document, color: AppColors.primary, size: 18),
            SizedBox(width: 8.w),
            Text(
              'Contract Document',
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        AppAttachmentTile(
          title: fileName,
          size: fileSize,
          fileExtension: 'PDF',
          onTap: onDownloadTap,
          onDownloadTap: onDownloadTap,
          trailingIcon: Icons.download_outlined,
        ),
      ],
    );
  }
}
