import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class SegmentedSelectorWidget<T> extends StatelessWidget {
  final T value;
  final ValueChanged<T> onChanged;
  final List<T> items;
  final String Function(T) itemTextBuilder;

  const SegmentedSelectorWidget({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    required this.itemTextBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: items.map((item) {
          final isSelected = value == item;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(item),
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  itemTextBuilder(item),
                  style: isSelected
                      ? AppTextStyles.font14Medium.copyWith(color: AppColors.white100)
                      : AppTextStyles.font14Medium.copyWith(color: AppColors.grey900),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
