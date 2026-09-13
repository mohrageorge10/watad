import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class ChangeOrderImpactItem extends StatelessWidget {
  final String iconPath;
  final Color color;
  final String value;
  final String label;

  const ChangeOrderImpactItem({
    super.key,
    required this.iconPath,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 16.w,
          height: 16.w,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              label,
              style: AppTextStyles.font10MediumDark.copyWith(
                color: AppColors.deactivation,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
