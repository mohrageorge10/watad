import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/marketplace_search_field.dart';

class MarketplaceSearchFilterSection extends StatelessWidget {
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onClearSearch;
  final VoidCallback? onFilterTap;

  const MarketplaceSearchFilterSection({
    super.key,
    this.searchController,
    this.onSearchChanged,
    this.onClearSearch,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        top: 24.h,
        bottom: 16.h,
      ),
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: MarketplaceSearchField(
              controller: searchController,
              onChanged: onSearchChanged,
              onClear: onClearSearch,
              hintText: 'Search projects...',
            ),
          ),
          SizedBox(width: 12.w),

          // Filter Button
          Container(
            width: 48.h,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFFE5E5EA),
                width: 1.w,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onFilterTap,
                borderRadius: BorderRadius.circular(12.r),
                child: Center(
                  child: Icon(
                    Icons.tune_rounded,
                    color: AppColors.primary,
                    size: 22.r,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
