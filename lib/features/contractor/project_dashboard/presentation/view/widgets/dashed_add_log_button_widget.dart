import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_dashed_box_widget.dart';

class DashedAddLogButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const DashedAddLogButtonWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashedBoxWidget(
      width: 80.w,
      height: 80.h,
      borderRadius: 12.r,
      strokeWidth: 1.5.w,
      color: const Color(0xFF1E3A8A).withValues(alpha: 0.6),
      onTap: onTap,
      child: Center(
        child: Icon(
          Icons.add_rounded,
          color: const Color(0xFF1E3A8A),
          size: 28.r,
        ),
      ),
    );
  }
}
