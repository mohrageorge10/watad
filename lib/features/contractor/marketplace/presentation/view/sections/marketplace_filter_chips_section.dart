import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/marketplace_filter_chip.dart';

class FilterChipData {
  final String label;
  final IconData? icon;

  const FilterChipData({
    required this.label,
    this.icon,
  });
}

class MarketplaceFilterChipsSection extends StatelessWidget {
  final String activeChip;
  final ValueChanged<String> onChipSelected;
  final List<FilterChipData> chips;

  const MarketplaceFilterChipsSection({
    super.key,
    required this.activeChip,
    required this.onChipSelected,
    this.chips = const [
      FilterChipData(label: 'All'),
      FilterChipData(label: 'Cairo'),
      FilterChipData(label: 'Giza'),
      FilterChipData(label: 'Budget'),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: chips.map((chip) {
            final isSelected = activeChip == chip.label;
            return Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: MarketplaceFilterChip(
                label: chip.label,
                icon: chip.icon,
                isSelected: isSelected,
                onTap: () => onChipSelected(chip.label),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
