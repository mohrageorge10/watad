import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';

class MarketplaceHeaderSection extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final String title;
  final bool showBackButton;

  const MarketplaceHeaderSection({
    super.key,
    this.onBackTap,
    this.onSettingsTap,
    this.title = 'Marketplace',
    this.showBackButton = false,
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
      padding: EdgeInsets.fromLTRB(20.w, 48.h, 20.w, 36.h),
      child: showBackButton
          ? Row(
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
                  splashRadius: 24.r,
                ),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white100,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 20.r),
              ],
            )
          : Center(
              child: Text(
                title,
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
