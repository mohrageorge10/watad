import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/custom_chip_widget.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/section_card_widget.dart';

class CoveredGovernoratesSection extends StatelessWidget {
  final ContractorProfileEntity profile;
  final VoidCallback? onEditTap;

  const CoveredGovernoratesSection({
    super.key,
    required this.profile,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasItems = profile.coveredGovernorates.isNotEmpty;

    return SectionCardWidget(
      icon: Icons.location_on_outlined,
      title: 'Covered Governorates',
      child: hasItems
          ? Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: profile.coveredGovernorates
                  .map(
                    (city) => CustomChipWidget(
                      label: city,
                      hasDot: true,
                      hasCloseIcon: false,
                    ),
                  )
                  .toList(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'No covered governorates added yet.',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF8E8E93),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                InkWell(
                  onTap: onEditTap ??
                      () {
                        context.push(AppRoutes.editProfile, extra: profile);
                      },
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
