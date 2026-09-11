import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_card.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class ContractNotesCard extends StatelessWidget {
  const ContractNotesCard({
    super.key,
    this.terms,
  });

  final String? terms;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.note_alt_outlined, color: AppColors.primary, size: 18),
            SizedBox(width: 8.w),
            Text(
              'Terms & Special Notes',
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        AppCard(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          border: Border.all(color: AppColors.grey200),
          child: Text(
            (terms != null && terms!.isNotEmpty)
                ? terms!
                : 'Payment for each phase is due within 7 days of milestone completion and owner approval. Contractor is responsible for site safety.',
            style: AppTextStyles.font12RegularGrey.copyWith(
              color: AppColors.grey800,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
