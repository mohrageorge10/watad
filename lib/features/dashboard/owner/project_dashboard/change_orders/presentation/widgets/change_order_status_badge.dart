import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import '../../domain/entities/change_order_details.dart';

class ChangeOrderStatusBadge extends StatelessWidget {
  final ChangeOrderReviewStatus status;

  const ChangeOrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.icon,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        _label,
        style: AppTextStyles.font10MediumDark.copyWith(
          color: AppColors.white100,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String get _label {
    switch (status) {
      case ChangeOrderReviewStatus.pending:
        return 'Pending';
      case ChangeOrderReviewStatus.approved:
        return 'Approved';
      case ChangeOrderReviewStatus.rejected:
        return 'Rejected';
    }
  }
}
