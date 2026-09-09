import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/project_summary.dart';
import '../widgets/project_list_item.dart';

class MyProjectsListSection extends StatelessWidget {
  final List<ProjectSummary> projects;

  const MyProjectsListSection({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("My Projects", style: AppTextStyles.font18SemiBoldDark),
              GestureDetector(
                onTap: () => context.push(AppRoutes.createProject),
                child: Row(
                  children: [
                    Icon(Icons.add, color: AppColors.primary, size: 18.sp),
                    SizedBox(width: 4.w),
                    Text("New Project", style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.primary)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final project = projects[index];
              return ProjectListItem(
                project: project,
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
