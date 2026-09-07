import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class RoleSelectionHeaderSection extends StatelessWidget {
  const RoleSelectionHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Choose your Role',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 48.h),
      ],
    );
  }
}
