import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class ContractorHeaderSection extends StatelessWidget {
  const ContractorHeaderSection({
    super.key,
    required this.userName,
    this.headline = 'Your operational command center. Everything',
    this.onNotificationTap,
    this.onProfileTap,
  });

  final String userName;
  final String headline;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;

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
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 30.h, 24.w, 60.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // User Greeting & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      userName.startsWith('Welcome')
                          ? userName
                          : 'Welcome $userName,',
                      style: TextStyle(
                        color: AppColors.white100,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      headline,
                      style: TextStyle(
                        color: AppColors.white100.withValues(alpha: 0.85),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              SizedBox(width: 16.w),

              // Action Icons: Bell & Avatar
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: onNotificationTap,
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.white100,
                      size: 24.r,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  SizedBox(width: 16.w),
                  GestureDetector(
                    onTap: onProfileTap,
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: AppColors.white100,
                      child: Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 22.r,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
