import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class MarketplaceSpecCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const MarketplaceSpecCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  factory MarketplaceSpecCard.fromStringIcon({
    Key? key,
    required String iconName,
    required String label,
    required String value,
  }) {
    IconData resolvedIcon;
    switch (iconName.toLowerCase()) {
      case 'expand':
      case 'land':
      case 'area':
        resolvedIcon = Icons.aspect_ratio_rounded;
        break;
      case 'layers':
      case 'floors':
        resolvedIcon = Icons.layers_outlined;
        break;
      case 'checkcircleoutline':
      case 'finishing':
        resolvedIcon = Icons.check_circle_outline_rounded;
        break;
      default:
        resolvedIcon = Icons.info_outline_rounded;
    }

    return MarketplaceSpecCard(
      key: key,
      icon: resolvedIcon,
      label: label,
      value: value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppColors.primary,
                size: 16.r,
              ),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF8E8E93),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1D1D1F),
            ),
          ),
        ],
      ),
    );
  }
}
