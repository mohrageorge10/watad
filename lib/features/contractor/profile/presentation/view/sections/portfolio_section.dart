import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/section_card_widget.dart';

class PortfolioSection extends StatelessWidget {
  final ContractorProfileEntity profile;
  final VoidCallback? onViewAllTap;

  const PortfolioSection({
    super.key,
    required this.profile,
    this.onViewAllTap,
  });



  @override
  Widget build(BuildContext context) {
    final images = profile.portfolioImages;

    return SectionCardWidget(
      icon: Icons.image_outlined,
      title: 'Portfolio',
      actionText: 'View All >',
      onActionTap: onViewAllTap,
      child: images.isEmpty
          ? Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF6F8FA),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFE5E5EA),
                  style: BorderStyle.solid,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add_photo_alternate_outlined,
                      color: AppColors.primary,
                      size: 22.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No portfolio photos yet',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1D1D1F),
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Add projects to showcase your quality work.',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF8E8E93),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(images.length.clamp(1, 4), (index) {
                final imageUrl = images[index];

                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    color: const Color(0xFFEDEFFE),
                    child: Image.network(
                      imageUrl,
                      width: 70.w,
                      height: 70.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 70.w,
                          height: 70.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEDEFFE),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.image_outlined,
                            color: AppColors.primary,
                            size: 26.r,
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
