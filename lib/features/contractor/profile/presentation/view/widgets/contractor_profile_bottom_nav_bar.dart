import 'package:flutter/material.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_bottom_nav_bar.dart';

class ContractorProfileBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const ContractorProfileBottomNavBar({
    super.key,
    this.currentIndex = 4,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ContractorBottomNavBar(
      currentIndex: currentIndex,
      onTap: (index) => onTap?.call(index),
    );
  }
}
