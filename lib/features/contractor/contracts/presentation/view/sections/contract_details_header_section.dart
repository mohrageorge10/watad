import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';

class ContractDetailsHeaderSection extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const ContractDetailsHeaderSection({
    super.key,
    this.title = 'Contract Details & Sign',
    this.onBackTap,
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
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onBackTap ??
                    () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.white100,
                  size: 20.r,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.white100,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: onSettingsTap ?? () {},
                icon: Icon(
                  Icons.settings_outlined,
                  color: AppColors.white100,
                  size: 24.r,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
