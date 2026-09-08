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

  // Curated architectural & construction photography matching the reference image
  static const List<String> _defaultImages = [
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=400&q=80',
    'https://images.unsplash.com/photo-1541888946425-d0fbb186c5f8?w=400&q=80',
    'https://images.unsplash.com/photo-1600565193348-f74bd3c7ccdf?w=400&q=80',
    'https://images.unsplash.com/photo-1504307651254-35680f356dfd?w=400&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return SectionCardWidget(
      icon: Icons.image_outlined,
      title: 'Portfolio',
      actionText: 'View All >',
      onActionTap: onViewAllTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) {
          final imageUrl = index < _defaultImages.length
              ? _defaultImages[index]
              : _defaultImages.first;

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
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 70.w,
                    height: 70.w,
                    color: const Color(0xFFF3F4F6),
                    child: Center(
                      child: SizedBox(
                        width: 18.r,
                        height: 18.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primary,
                        ),
                      ),
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
