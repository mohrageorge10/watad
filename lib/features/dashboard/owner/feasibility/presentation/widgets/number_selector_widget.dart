import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class NumberSelectorWidget extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  const NumberSelectorWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 100,
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
        children: [
          Expanded(
            child: InkWell(
              onTap: value > min ? () => onChanged(value - 1) : null,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
              child: Center(
                child: Icon(
                  Icons.remove,
                  color: AppColors.grey900,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          Container(
            width: 120.w,
            margin: EdgeInsets.symmetric(vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Text(
              value.toString(),
              style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.white100),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: value < max ? () => onChanged(value + 1) : null,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(12.r)),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: AppColors.grey900,
                  size: 20.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
