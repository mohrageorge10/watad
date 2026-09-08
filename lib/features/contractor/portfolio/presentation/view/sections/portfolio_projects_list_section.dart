import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/presentation/view/widgets/portfolio_project_card.dart';

class PortfolioProjectsListSection extends StatelessWidget {
  final List<PortfolioProjectItemModel> projects;
  final ValueChanged<PortfolioProjectItemModel>? onProjectTap;
  final ValueChanged<PortfolioProjectItemModel>? onViewDetailsTap;

  const PortfolioProjectsListSection({
    super.key,
    required this.projects,
    this.onProjectTap,
    this.onViewDetailsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: "My Projects" & "5 Projects"
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'My Projects',
                  style: TextStyle(
                    color: const Color(0xFF1D1D1F),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${projects.length} Projects',
                  style: TextStyle(
                    color: const Color(0xFF8E8E93),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Projects List Items
          ...projects.map(
            (project) => PortfolioProjectCard(
              project: project,
              onTap: () => onProjectTap?.call(project),
              onViewDetailsTap: () => onViewDetailsTap?.call(project),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
