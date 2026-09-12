import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_shimmer.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_my_projects_cubit.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_my_projects_state.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_my_project_card_widget.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_bottom_nav_bar.dart';

class ContractorMyProjectsScreen extends StatelessWidget {
  final bool showBottomNavBar;
  final VoidCallback? onBackTap;
  final VoidCallback? onNavigateToMarketplace;
  final VoidCallback? onNavigateToProfile;

  const ContractorMyProjectsScreen({
    super.key,
    this.showBottomNavBar = false,
    this.onBackTap,
    this.onNavigateToMarketplace,
    this.onNavigateToProfile,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContractorMyProjectsCubit>()..loadProjects(),
      child: _ContractorMyProjectsView(
        showBottomNavBar: showBottomNavBar,
        onBackTap: onBackTap,
        onNavigateToMarketplace: onNavigateToMarketplace,
        onNavigateToProfile: onNavigateToProfile,
      ),
    );
  }
}

class _ContractorMyProjectsView extends StatefulWidget {
  final bool showBottomNavBar;
  final VoidCallback? onBackTap;
  final VoidCallback? onNavigateToMarketplace;
  final VoidCallback? onNavigateToProfile;

  const _ContractorMyProjectsView({
    required this.showBottomNavBar,
    this.onBackTap,
    this.onNavigateToMarketplace,
    this.onNavigateToProfile,
  });

  @override
  State<_ContractorMyProjectsView> createState() =>
      _ContractorMyProjectsViewState();
}

class _ContractorMyProjectsViewState extends State<_ContractorMyProjectsView> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<ContractorMyProjectsCubit>().loadProjects();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Section (Curved primary app bar)
              _buildHeader(context),

              // 2. Search & Filter Bar (Floating slightly over header)
              Transform.translate(
                offset: Offset(0, -22.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      // Search field
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white100,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (query) {
                              context
                                  .read<ContractorMyProjectsCubit>()
                                  .searchProjects(query);
                            },
                            decoration: InputDecoration(
                              hintText: 'Search by project name...',
                              hintStyle: TextStyle(
                                fontSize: 13.sp,
                                color: const Color(0xFF8E8E93),
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: const Color(0xFF8E8E93),
                                size: 20.r,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),

                      // Filter Button
                      Container(
                        height: 48.h,
                        width: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.white100,
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(14.r),
                            child: Icon(
                              Icons.tune_rounded,
                              color: AppColors.primary,
                              size: 20.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Projects List
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: BlocBuilder<ContractorMyProjectsCubit,
                    ContractorMyProjectsState>(
                  builder: (context, state) {
                    if (state is ContractorMyProjectsLoading ||
                        state is ContractorMyProjectsInitial) {
                      return const ListShimmer(itemCount: 4, itemHeight: 95);
                    }

                    if (state is ContractorMyProjectsError) {
                      return AppEmptyStateWidget(
                        title: 'Error Loading Projects',
                        message: state.message,
                        buttonTitle: 'Try Again',
                        onButtonPressed: () {
                          context
                              .read<ContractorMyProjectsCubit>()
                              .loadProjects();
                        },
                      );
                    }

                    if (state is ContractorMyProjectsEmpty) {
                      return Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: AppEmptyStateWidget(
                          title: 'No Active Projects',
                          message: state.message,
                          buttonTitle: 'Explore Marketplace',
                          onButtonPressed: () {
                            if (widget.onNavigateToMarketplace != null) {
                              widget.onNavigateToMarketplace!();
                            } else {
                              context.pushNamed(AppRoutes.marketplace);
                            }
                          },
                        ),
                      );
                    }

                    if (state is ContractorMyProjectsSuccess) {
                      final projects = state.filteredProjects;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          final project = projects[index];
                          return ContractorMyProjectCardWidget(
                            project: project,
                            onDashboardTap: () {
                              context.pushNamed(
                                AppRoutes.contractorProjectDashboard,
                                extra: {
                                  'projectId': project.id,
                                  'projectName': project.title,
                                },
                              );
                            },
                            onViewContractTap: () {
                              context.pushNamed(
                                AppRoutes.contractPreview,
                                extra: {
                                  'contractId': project.contractId ?? project.id,
                                  'bidId': project.id,
                                },
                              );
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.showBottomNavBar
          ? ContractorBottomNavBar(
              currentIndex: 2,
              onTap: (index) {},
            )
          : null,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 48.h, 20.w, 36.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24.r),
          bottomRight: Radius.circular(24.r),
        ),
      ),
      child: Center(
        child: Text(
          'My Projects',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white100,
          ),
        ),
      ),
    );
  }
}
