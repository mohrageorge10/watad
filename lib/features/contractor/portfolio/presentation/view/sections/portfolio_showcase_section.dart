import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/portfolio/presentation/view/widgets/portfolio_showcase_card.dart';

class PortfolioShowcaseSection extends StatelessWidget {
  final VoidCallback? onAddProjectTap;

  const PortfolioShowcaseSection({
    super.key,
    this.onAddProjectTap,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -32.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: PortfolioShowcaseCard(
          onAddProjectTap: onAddProjectTap,
        ),
      ),
    );
  }
}
