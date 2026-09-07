import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class ProjectProgressBar extends StatelessWidget {
  final int progressPercent;
  final bool isDarkBackground;

  const ProjectProgressBar({
    super.key,
    required this.progressPercent,
    this.isDarkBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final trackColor = isDarkBackground
        ? AppColors.white100.withOpacity(0.2)
        : AppColors.signUp; // E6E6E6
    
    final fillColor = isDarkBackground
        ? AppColors.white100
        : AppColors.primary;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 6.h,
          decoration: BoxDecoration(
            color: trackColor,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final fillWidth = constraints.maxWidth * (progressPercent / 100);
            return Container(
              width: fillWidth,
              height: 6.h,
              decoration: BoxDecoration(
                color: fillColor,
                borderRadius: BorderRadius.circular(3.r),
              ),
            );
          },
        ),
      ],
    );
  }
}
