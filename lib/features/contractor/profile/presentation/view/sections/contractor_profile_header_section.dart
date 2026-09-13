import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class ContractorProfileHeaderSection extends StatelessWidget {
  final VoidCallback? onSettingsTap;

  const ContractorProfileHeaderSection({
    super.key,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 48.h, 20.w, 85.h),
      child: Center(
        child: Text(
          'Contractor Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.white100,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
