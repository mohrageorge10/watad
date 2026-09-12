import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class ChangeOrderCardActions extends StatelessWidget {
  final VoidCallback? onViewDetails;
  final VoidCallback? onReject;
  final VoidCallback? onAccept;

  const ChangeOrderCardActions({
    super.key,
    this.onViewDetails,
    this.onReject,
    this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onViewDetails,
          child: Text(
            'View Details',
            style: AppTextStyles.font12MediumGrey.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 32.h,
          child: OutlinedButton(
            onPressed: onReject,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.alert,
              side: const BorderSide(color: AppColors.alert),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Text(
              'Reject',
              style: AppTextStyles.font12MediumGrey.copyWith(
                color: AppColors.alert,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 8.w),
        SizedBox(
          height: 32.h,
          child: ElevatedButton(
            onPressed: onAccept,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accept,
              foregroundColor: AppColors.white100,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Text(
              'Accept',
              style: AppTextStyles.font12MediumGrey.copyWith(
                color: AppColors.white100,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
