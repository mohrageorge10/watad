import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class ProjectStatusBadge extends StatelessWidget {
  const ProjectStatusBadge({super.key, required this.status});

  final String status;

  Color get _backgroundColor {
    switch (status.toLowerCase()) {
      case 'in progress':
        return AppColors.accept;
      case 'design phase':
        return AppColors.icon;
      case 'draft':
        return AppColors.deactivation;
      case 'feasibility calculated':
        return AppColors.primary;
      case 'completed':
        return AppColors.accept;
      default:
        return AppColors.deactivation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        status,
        style: AppTextStyles.btnGrey600.copyWith(color: AppColors.white100),
      ),
    );
  }
}
