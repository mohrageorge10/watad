import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/marketplace_project_card.dart';

class MarketplaceProjectsListSection extends StatelessWidget {
  final List<MarketplaceProjectEntity> projects;
  final ValueChanged<MarketplaceProjectEntity>? onProjectTap;
  final ValueChanged<MarketplaceProjectEntity>? onViewDetailsTap;
  final ValueChanged<String>? onBookmarkTap;

  const MarketplaceProjectsListSection({
    super.key,
    required this.projects,
    this.onProjectTap,
    this.onViewDetailsTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.w,
        right: 24.w,
        bottom: 32.h,
      ),
      child: Column(
        children: projects.map((project) {
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: MarketplaceProjectCard(
              project: project,
              onTap: () => onProjectTap?.call(project),
              onViewDetailsTap: () => onViewDetailsTap?.call(project),
              onBookmarkTap: () => onBookmarkTap?.call(project.id),
            ),
          );
        }).toList(),
      ),
    );
  }
}
