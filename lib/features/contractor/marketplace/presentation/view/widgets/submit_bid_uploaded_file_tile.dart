import 'package:flutter/material.dart';
import 'package:watad/core/shared/widgets/app_attachment_tile_widget.dart';

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
    return AppAttachmentTileWidget(
      title: fileName,
      size: fileSize,
      trailingIcon: Icons.close_rounded,
      onTrailingTap: onRemove,
    );
  }
}
