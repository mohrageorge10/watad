import 'package:flutter/material.dart';
import 'package:watad/core/shared/widgets/app_dashed_box_widget.dart';

class DashedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? color;
  final double? borderRadius;

  const DashedButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashedBoxWidget(
      text: text,
      color: color,
      borderRadius: borderRadius,
      onTap: onTap,
    );
  }
}
