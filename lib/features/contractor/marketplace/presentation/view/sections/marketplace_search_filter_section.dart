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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
          SizedBox(width: 10.w),

          // Filter Button
          Container(
            width: 48.h,
            height: 48.h,
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onFilterTap,
                borderRadius: BorderRadius.circular(14.r),
                child: Center(
                  child: Icon(
                    Icons.tune_rounded,
                    color: AppColors.primary,
                    size: 20.r,
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
