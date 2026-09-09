import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class AlertCategoryChips extends StatelessWidget {
  final List<String> categories;
  final String activeCategory;
  final ValueChanged<String> onCategorySelected;

  const AlertCategoryChips({
    super.key,
    required this.categories,
    required this.activeCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        children: categories.map((category) {
          final isActive = category == activeCategory;
          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: GestureDetector(
              onTap: () => onCategorySelected(category),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.grey200,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : null,
                ),
                child: Text(
                  category,
                  style: AppTextStyles.font14Medium.copyWith(
                    color: isActive ? AppColors.white100 : AppColors.primary,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
