import 'package:flutter/material.dart';
import 'package:watad/core/shared/widgets/app_attachment_tile_widget.dart';

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
    return AppAttachmentTileWidget(
      title: title,
      size: size,
      leadingIcon: leadingIcon,
      badgeColor: leadingColor,
      trailingIcon: trailingIcon,
      onTap: onTap ?? onDownloadTap,
      onTrailingTap: onDownloadTap ?? onTap,
    );
  }
}
