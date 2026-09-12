import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_projects_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_projects_state.dart';
import 'package:watad/features/dashboard/owner/home/presentation/widgets/project_list_item.dart';


class HomeProjectsSection extends StatelessWidget {
  const HomeProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My Projects', style: AppTextStyles.font16SemiBold),
            TextButton(
              onPressed: () => context.push(AppRoutes.createProject),
              child: Text('+ New Project', style: AppTextStyles.primary600),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        BlocBuilder<HomeProjectsCubit, HomeProjectsState>(
          builder: (context, state) {
            switch (state.status) {
              case HomeProjectsStatus.initial:
              case HomeProjectsStatus.loading:
                return const ListShimmer(itemCount: 3, itemHeight: 74);

              case HomeProjectsStatus.empty:
                return const AppEmptyStateWidget(
                  title: 'No Projects Yet',
                  message: 'Start your first project to see it here.',
                );

              case HomeProjectsStatus.failure:
                return const AppEmptyStateWidget(
                  title: 'No Projects Yet',
                  message: 'Start your first project to see it here.',
                );

              case HomeProjectsStatus.success:
              case HomeProjectsStatus.loadingMore:
                return Column(
                  children: [
                    for (final project in state.items) ...[
                      ProjectListItem(
                        project: project,
                        onTap: () {
                          // TODO: context.pushNamed(Routes.projectDetails, arguments: project.projectId);
                        },
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ],
                );
            }
          },
        ),
      ],
    );
  }
}
