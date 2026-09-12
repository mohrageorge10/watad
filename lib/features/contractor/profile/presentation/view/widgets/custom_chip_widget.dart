import 'package:flutter/material.dart';
import 'package:watad/core/shared/widgets/app_chip_widget.dart';

class CustomChipWidget extends StatelessWidget {
  final String label;
  final bool hasDot;
  final bool hasCloseIcon;
  final VoidCallback? onCloseTap;
  final Color? dotColor;
  final Color? backgroundColor;

  const CustomChipWidget({
    super.key,
    required this.label,
    this.hasDot = false,
    this.hasCloseIcon = false,
    this.onCloseTap,
    this.dotColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppChipWidget(
      label: label,
      isActive: false,
      hasDot: hasDot,
      hasCloseIcon: hasCloseIcon,
      dotColor: dotColor,
      backgroundColor: backgroundColor,
      onCloseTap: onCloseTap,
    );
  }
}
