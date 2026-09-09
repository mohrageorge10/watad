import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_project_entity.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_empty_card_widget.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/project_card_widget.dart';

class ActiveProjectsSection extends StatelessWidget {
  const ActiveProjectsSection({
    super.key,
    required this.projects,
    this.ongoingCount,
    this.onViewAllTap,
    this.onProjectTap,
    this.onExploreTap,
  });

  final List<ContractorProjectEntity> projects;
  final int? ongoingCount;
  final VoidCallback? onViewAllTap;
  final ValueChanged<ContractorProjectEntity>? onProjectTap;
  final VoidCallback? onExploreTap;

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = projects.isEmpty;
    final String actionText = isEmpty
        ? '${ongoingCount ?? 0} Ongoing ➔'
        : 'View All ➔';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Projects',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1D1D1F),
                ),
              ),
              InkWell(
                onTap: onViewAllTap,
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Text(
                    actionText,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Project Cards or Empty Card matching the design
          if (isEmpty)
            ContractorEmptyCardWidget(
              title: 'No Active Projects Yet',
              message:
                  'Start exploring the market place to submit proposals or track your contracted projects here',
              buttonTitle: 'Explore Marketplace',
              onButtonPressed: onExploreTap,
            )
          else
            ...projects.map(
              (project) => ProjectCardWidget(
                title: project.title,
                location: project.location,
                timeOrAmount: project.time,
                badgeText: project.badgeText,
                badgeColorHex: project.badgeColorHex,
                progress: project.progress,
                imagePath: project.image,
                onTap: onProjectTap != null ? () => onProjectTap!(project) : null,
              ),
            ),
        ],
      ),
    );
  }
}
