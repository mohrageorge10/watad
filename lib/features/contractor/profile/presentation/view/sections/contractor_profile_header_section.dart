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
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(
            top: 16.h,
            left: 20.w,
            right: 20.w,
            bottom: 75.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Dummy spacer to balance the settings button and keep title centered
              SizedBox(width: 32.r),

              Text(
                'Contractor Profile',
                style: TextStyle(
                  color: AppColors.white100,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              IconButton(
                onPressed: onSettingsTap,
                icon: const Icon(
                  Icons.settings_outlined,
                  color: AppColors.white100,
                ),
                iconSize: 22.r,
                splashRadius: 24.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
