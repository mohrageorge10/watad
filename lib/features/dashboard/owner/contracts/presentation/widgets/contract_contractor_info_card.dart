import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_card.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

class ContractContractorInfoCard extends StatelessWidget {
  const ContractContractorInfoCard({
    super.key,
    this.name = 'BuildPro Construction',
    this.rating = '4.8 (120)',
    this.logoAsset = 'assets/images/logo.png',
    this.onPhoneTap,
  });

  final String name;
  final String rating;
  final String logoAsset;
  final VoidCallback? onPhoneTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(16.r),
      border: Border.all(color: AppColors.grey200),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundImage: AssetImage(logoAsset),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.font14SemiBoldDark.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.accent, size: 14),
                    SizedBox(width: 4.w),
                    Text(
                      rating,
                      style: AppTextStyles.font12RegularGrey,
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onPhoneTap,
            icon: const Icon(Icons.phone_outlined, color: AppColors.primary),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
