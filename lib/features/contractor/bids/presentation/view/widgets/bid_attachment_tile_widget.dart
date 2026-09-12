import 'package:flutter/material.dart';
import 'package:watad/core/shared/widgets/app_attachment_tile_widget.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';

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
    return AppAttachmentTileWidget(
      title: title,
      size: size,
      hasBorder: false,
      onTap: onDownloadTap ??
          () {
            AppToast.showInfo(context, 'Downloading $title...');
          },
      onTrailingTap: onDownloadTap ??
          () {
            AppToast.showInfo(context, 'Downloading $title...');
          },
    );
  }
}
