import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/auth/data/models/role_model.dart';

class RoleCardWidget extends StatelessWidget {
  const RoleCardWidget({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  final RoleModel role;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000), // #0000001A
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.h,
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : const Color(0xFFF6F8FA),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Image.asset(
                    role.icon,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person_outline,
                      color: isSelected ? AppColors.primary : AppColors.grey500,
                      size: 24.sp,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    role.title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected ? AppColors.primary : AppColors.smallText,
                    ),
                  ),
                ),
                Container(
                  width: 22.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.grey400,
                      width: 2,
                    ),
                    color: isSelected ? AppColors.primary : Colors.transparent,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 14.sp,
                          color: AppColors.white100,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
