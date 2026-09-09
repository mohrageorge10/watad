import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';

class MyBidsFilterChipsWidget extends StatelessWidget {
  final String activeFilter;
  final int allCount;
  final int pendingCount;
  final int acceptedCount;
  final int rejectedCount;
  final ValueChanged<String> onFilterSelected;

  const MyBidsFilterChipsWidget({
    super.key,
    required this.activeFilter,
    required this.allCount,
    required this.pendingCount,
    required this.acceptedCount,
    required this.rejectedCount,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'key': 'All', 'label': 'All ($allCount)'},
      {'key': 'Pending Review', 'label': 'Pending Review ($pendingCount)'},
      {'key': 'Accepted', 'label': 'Accepted ($acceptedCount)'},
      {'key': 'Rejected', 'label': 'Rejected ($rejectedCount)'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((item) {
          final key = item['key']!;
          final label = item['label']!;
          final isActive = activeFilter == key;

          return Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: InkWell(
              onTap: () => onFilterSelected(key),
              borderRadius: BorderRadius.circular(20.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : AppColors.white100,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isActive
                        ? AppColors.primary
                        : const Color(0xFFE5E5EA),
                    width: 1,
                  ),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: isActive ? AppColors.white100 : AppColors.primary,
                    fontSize: 13.sp,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
