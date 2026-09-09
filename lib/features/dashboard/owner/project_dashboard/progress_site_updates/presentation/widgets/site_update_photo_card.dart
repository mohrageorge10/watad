import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import '../../domain/entities/site_update_photo.dart';

class SiteUpdatePhotoCard extends StatelessWidget {
  final SiteUpdatePhoto photo;

  const SiteUpdatePhotoCard({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              photo.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.grey100,
                child: Icon(Icons.image_not_supported_outlined, color: AppColors.grey400),
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          photo.title,
          style: AppTextStyles.font14SemiBoldDark.copyWith(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.h),
        Text(
          photo.timeText,
          style: AppTextStyles.font12RegularGrey.copyWith(
            fontSize: 11.sp,
            color: AppColors.grey500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
