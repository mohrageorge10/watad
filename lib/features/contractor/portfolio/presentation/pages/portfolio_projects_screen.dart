import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_cubit.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_state.dart';
import 'package:watad/features/contractor/portfolio/presentation/view/sections/portfolio_header_section.dart';
import 'package:watad/features/contractor/portfolio/presentation/view/sections/portfolio_projects_list_section.dart';
import 'package:watad/features/contractor/portfolio/presentation/view/sections/portfolio_shimmer_section.dart';
import 'package:watad/features/contractor/portfolio/presentation/view/sections/portfolio_showcase_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/contractor_profile_bottom_nav_bar.dart';

class PortfolioProjectsScreen extends StatelessWidget {
  final List<PortfolioProjectItemModel>? projects;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onAddProjectTap;
  final ValueChanged<PortfolioProjectItemModel>? onProjectTap;
  final ValueChanged<PortfolioProjectItemModel>? onViewDetailsTap;
  final bool showBottomNavBar;

  const PortfolioProjectsScreen({
    super.key,
    this.projects,
    this.onBackTap,
    this.onSettingsTap,
    this.onAddProjectTap,
    this.onProjectTap,
    this.onViewDetailsTap,
    this.showBottomNavBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PortfolioCubit>()..loadProjects(),
      child: _PortfolioProjectsView(
        overrideProjects: projects,
        onBackTap: onBackTap,
        onSettingsTap: onSettingsTap,
        onAddProjectTap: onAddProjectTap,
        onProjectTap: onProjectTap,
        onViewDetailsTap: onViewDetailsTap,
        showBottomNavBar: showBottomNavBar,
      ),
    );
  }
}

class _PortfolioProjectsView extends StatelessWidget {
  final List<PortfolioProjectItemModel>? overrideProjects;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onAddProjectTap;
  final ValueChanged<PortfolioProjectItemModel>? onProjectTap;
  final ValueChanged<PortfolioProjectItemModel>? onViewDetailsTap;
  final bool showBottomNavBar;

  const _PortfolioProjectsView({
    this.overrideProjects,
    this.onBackTap,
    this.onSettingsTap,
    this.onAddProjectTap,
    this.onProjectTap,
    this.onViewDetailsTap,
    required this.showBottomNavBar,
  });

  void _handleBottomNavTap(BuildContext context, int index) {
    if (index == 2) return;
    if (index == 0) {
      context.go(AppRoutes.home);
    } else if (index == 4) {
      context.push(AppRoutes.contractorProfile);
    }
  }

  void _handleAddProject(BuildContext context) {
    if (onAddProjectTap != null) {
      onAddProjectTap!();
    } else {
      context.push(AppRoutes.addPortfolioProject).then((val) {
        if (val == true && context.mounted) {
          context.read<PortfolioCubit>().loadProjects();
        }
      });
    }
  }

  void _handleProjectTap(BuildContext context, PortfolioProjectItemModel project) {
    if (onProjectTap != null) {
      onProjectTap!(project);
    } else if (onViewDetailsTap != null) {
      onViewDetailsTap!(project);
    } else {
      context.push(AppRoutes.portfolioProjectDetails, extra: project).then((val) {
        if (val == true && context.mounted) {
          context.read<PortfolioCubit>().loadProjects();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          if (overrideProjects != null) {
            return _buildContent(context, overrideProjects!);
          }

          if (state is PortfolioLoading) {
            return PortfolioShimmerSection(onBackTap: onBackTap);
          }

          if (state is PortfolioError) {
            return Center(
              child: AppEmptyStateWidget(
                title: 'Something went wrong',
                message: state.message,
                buttonTitle: 'Try Again',
                onButtonPressed: () {
                  context.read<PortfolioCubit>().loadProjects();
                },
              ),
            );
          }

          if (state is PortfolioEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<PortfolioCubit>().loadProjects();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    PortfolioHeaderSection(
                      onBackTap: onBackTap,
                      onSettingsTap: onSettingsTap,
                    ),
                    PortfolioShowcaseSection(
                      onAddProjectTap: () => _handleAddProject(context),
                    ),
                    SizedBox(height: 40.h),
                    AppEmptyStateWidget(
                      title: 'No Projects Yet',
                      message: 'You have not added any projects to your portfolio yet.',
                      buttonTitle: 'Add Your First Project',
                      onButtonPressed: () => _handleAddProject(context),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is PortfolioSuccess) {
            return _buildContent(context, state.projects);
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: showBottomNavBar
          ? ContractorProfileBottomNavBar(
              currentIndex: 2,
              onTap: (index) => _handleBottomNavTap(context, index),
            )
          : null,
    );
  }

  Widget _buildContent(BuildContext context, List<PortfolioProjectItemModel> projects) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<PortfolioCubit>().loadProjects();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PortfolioHeaderSection(
              onBackTap: onBackTap,
              onSettingsTap: onSettingsTap,
            ),
            PortfolioShowcaseSection(
              onAddProjectTap: () => _handleAddProject(context),
            ),
            Transform.translate(
              offset: Offset(0, -16.h),
              child: PortfolioProjectsListSection(
                projects: projects,
                onProjectTap: (p) => _handleProjectTap(context, p),
                onViewDetailsTap: (p) => _handleProjectTap(context, p),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
