import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/stat_item_widget.dart';

class StatsCardSection extends StatelessWidget {
  final ContractorProfileEntity profile;

  const StatsCardSection({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            StatItemWidget(
              title: 'Years of\nExperience',
              value: profile.yearsOfExperience,
            ),
            const VerticalDivider(
              color: Color(0xFFE5E5EA),
              thickness: 1,
              width: 1,
              indent: 4,
              endIndent: 4,
            ),
            StatItemWidget(
              title: 'Rating\nAverage',
              value: profile.rating.toString(),
            ),
            const VerticalDivider(
              color: Color(0xFFE5E5EA),
              thickness: 1,
              width: 1,
              indent: 4,
              endIndent: 4,
            ),
            StatItemWidget(
              title: 'Projects\nCompiled',
              value: profile.projectsCompiled,
            ),
            const VerticalDivider(
              color: Color(0xFFE5E5EA),
              thickness: 1,
              width: 1,
              indent: 4,
              endIndent: 4,
            ),
            StatItemWidget(
              title: 'Verification\nStatus',
              value: profile.verificationStatus,
              valueColor: const Color(0xFF00B368),
            ),
          ],
        ),
      ),
    );
  }
}
