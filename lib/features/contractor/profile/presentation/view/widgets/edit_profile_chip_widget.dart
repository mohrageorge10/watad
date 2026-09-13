import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_chip_widget.dart';

class EditProfileChipWidget extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool hasCloseIcon;
  final VoidCallback? onTap;
  final VoidCallback? onCloseTap;

  const EditProfileChipWidget({
    super.key,
    required this.text,
    this.isActive = true,
    this.hasCloseIcon = false,
    this.onTap,
    this.onCloseTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppChipWidget(
      label: text,
      isActive: isActive,
      hasCloseIcon: hasCloseIcon,
      onTap: onTap,
      onCloseTap: onCloseTap,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
    );
  }
}
