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
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_bottom_nav_bar.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_my_project_card_widget.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_cubit.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_state.dart';
import 'package:watad/features/contractor/portfolio/presentation/view/widgets/portfolio_project_card.dart';

class ContractorMyProjectsScreen extends StatelessWidget {
  final bool showBottomNavBar;
  final int initialTabIndex;
  final VoidCallback? onBackTap;
  final VoidCallback? onNavigateToMarketplace;
  final VoidCallback? onNavigateToProfile;

  const ContractorMyProjectsScreen({
    super.key,
    this.showBottomNavBar = false,
    this.initialTabIndex = 0,
    this.onBackTap,
    this.onNavigateToMarketplace,
    this.onNavigateToProfile,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ContractorMyProjectsCubit>()..loadProjects(),
        ),
        BlocProvider(
          create: (context) => sl<PortfolioCubit>()..loadProjects(),
        ),
      ],
      child: _ContractorMyProjectsView(
        showBottomNavBar: showBottomNavBar,
        initialTabIndex: initialTabIndex,
        onBackTap: onBackTap,
        onNavigateToMarketplace: onNavigateToMarketplace,
        onNavigateToProfile: onNavigateToProfile,
      ),
    );
  }
}

class _ContractorMyProjectsView extends StatefulWidget {
  final bool showBottomNavBar;
  final int initialTabIndex;
  final VoidCallback? onBackTap;
  final VoidCallback? onNavigateToMarketplace;
  final VoidCallback? onNavigateToProfile;

  const _ContractorMyProjectsView({
    required this.showBottomNavBar,
    this.initialTabIndex = 0,
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
  late int _selectedTabIndex; // 0: Active Projects, 1: Portfolio

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.initialTabIndex;
    _searchController = TextEditingController();
  }

  @override
  void didUpdateWidget(covariant _ContractorMyProjectsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialTabIndex != widget.initialTabIndex) {
      setState(() {
        _selectedTabIndex = widget.initialTabIndex;
      });
    }
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
          await Future.wait([
            context.read<ContractorMyProjectsCubit>().loadProjects(),
            context.read<PortfolioCubit>().loadProjects(),
          ]);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header Section (Curved primary app bar with Title)
              _buildHeader(context),

              // 2. Search Bar (Floating slightly over header)
              Transform.translate(
                offset: Offset(0, -22.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                        if (_selectedTabIndex == 0) {
                          context
                              .read<ContractorMyProjectsCubit>()
                              .searchProjects(query);
                        } else {
                          setState(() {});
                        }
                      },
                      decoration: InputDecoration(
                        hintText: _selectedTabIndex == 0
                            ? 'Search active projects...'
                            : 'Search portfolio projects...',
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
              ),

              // 3. Modern Segmented Tab Bar (Active Projects vs Portfolio)
              Transform.translate(
                offset: Offset(0, -10.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Row(
                      children: [
                        // Tab 0: Active Projects
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (_selectedTabIndex != 0) {
                                setState(() => _selectedTabIndex = 0);
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: _selectedTabIndex == 0
                                    ? AppColors.white100
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: _selectedTabIndex == 0
                                    ? [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.08),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.business_center_rounded,
                                      size: 16.r,
                                      color: _selectedTabIndex == 0
                                          ? AppColors.primary
                                          : const Color(0xFF64748B),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Active Projects',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: _selectedTabIndex == 0
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                        color: _selectedTabIndex == 0
                                            ? AppColors.primary
                                            : const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Tab 1: Portfolio
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (_selectedTabIndex != 1) {
                                setState(() => _selectedTabIndex = 1);
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: _selectedTabIndex == 1
                                    ? AppColors.white100
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: _selectedTabIndex == 1
                                    ? [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.08),
                                          blurRadius: 6,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.photo_library_rounded,
                                      size: 16.r,
                                      color: _selectedTabIndex == 1
                                          ? AppColors.primary
                                          : const Color(0xFF64748B),
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      'Portfolio',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: _selectedTabIndex == 1
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                        color: _selectedTabIndex == 1
                                            ? AppColors.primary
                                            : const Color(0xFF64748B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 4. Tab Content (Active Projects OR Portfolio)
              _selectedTabIndex == 0
                  ? _buildActiveProjectsSection(context)
                  : _buildPortfolioSection(context),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.showBottomNavBar
          ? ContractorBottomNavBar(
              currentIndex: 2,
              onTap: (index) {
                if (index == 0) {
                  context.go(AppRoutes.home);
                } else if (index == 1) {
                  context.go(AppRoutes.marketplace);
                } else if (index == 2) {
                  // already on my projects
                } else if (index == 3) {
                  context.go(AppRoutes.myBids);
                } else if (index == 4) {
                  context.go(AppRoutes.contractorProfile);
                }
              },
            )
          : null,
    );
  }

  Widget _buildActiveProjectsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<ContractorMyProjectsCubit, ContractorMyProjectsState>(
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
                context.read<ContractorMyProjectsCubit>().loadProjects();
              },
            );
          }

          if (state is ContractorMyProjectsEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: AppEmptyStateWidget(
                title: 'No Active Projects Yet',
                message:
                    'Explore the marketplace to bid on new projects and start working.',
                buttonTitle: 'Explore Marketplace',
                onButtonPressed: () {
                  if (widget.onNavigateToMarketplace != null) {
                    widget.onNavigateToMarketplace!();
                  } else {
                    context.go(AppRoutes.marketplace);
                  }
                },
              ),
            );
          }

          if (state is ContractorMyProjectsSuccess) {
            final projects = state.filteredProjects;

            if (projects.isEmpty) {
              return Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: AppEmptyStateWidget(
                  title: 'No Matching Projects',
                  message: 'No active projects match your search query.',
                  buttonTitle: 'Clear Search',
                  onButtonPressed: () {
                    _searchController.clear();
                    context
                        .read<ContractorMyProjectsCubit>()
                        .searchProjects('');
                  },
                ),
              );
            }

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
    );
  }

  Widget _buildPortfolioSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with count and "+ Add Project" button
          BlocBuilder<PortfolioCubit, PortfolioState>(
            builder: (context, state) {
              int count = 0;
              if (state is PortfolioSuccess) {
                count = state.projects.length;
              }
              return Padding(
                padding: EdgeInsets.only(bottom: 14.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Portfolio Projects ($count)',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1D1D1F),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final res =
                            await context.push(AppRoutes.addPortfolioProject);
                        if (res == true && context.mounted) {
                          context.read<PortfolioCubit>().loadProjects();
                        }
                      },
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_circle_outline_rounded,
                              size: 16.r,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Add Project',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Portfolio List / States
          BlocBuilder<PortfolioCubit, PortfolioState>(
            builder: (context, state) {
              if (state is PortfolioLoading || state is PortfolioInitial) {
                return const ListShimmer(itemCount: 3, itemHeight: 110);
              }

              if (state is PortfolioError) {
                return AppEmptyStateWidget(
                  title: 'Error Loading Portfolio',
                  message: state.message,
                  buttonTitle: 'Try Again',
                  onButtonPressed: () {
                    context.read<PortfolioCubit>().loadProjects();
                  },
                );
              }

              if (state is PortfolioEmpty) {
                return Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: AppEmptyStateWidget(
                    title: 'No Portfolio Projects Yet',
                    message:
                        'Showcase your best completed projects to attract high-value clients.',
                    buttonTitle: '+ Add Portfolio Project',
                    onButtonPressed: () async {
                      final res =
                          await context.push(AppRoutes.addPortfolioProject);
                      if (res == true && context.mounted) {
                        context.read<PortfolioCubit>().loadProjects();
                      }
                    },
                  ),
                );
              }

              if (state is PortfolioSuccess) {
                final query = _searchController.text.trim().toLowerCase();
                final projects = query.isEmpty
                    ? state.projects
                    : state.projects.where((p) {
                        return p.title.toLowerCase().contains(query) ||
                            p.location.toLowerCase().contains(query) ||
                            p.description.toLowerCase().contains(query);
                      }).toList();

                if (projects.isEmpty) {
                  if (query.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: AppEmptyStateWidget(
                        title: 'No Matching Projects',
                        message: 'No portfolio projects match "$query".',
                        buttonTitle: 'Clear Search',
                        onButtonPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      ),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: AppEmptyStateWidget(
                      title: 'No Portfolio Projects Yet',
                      message:
                          'Showcase your best completed projects to attract high-value clients.',
                      buttonTitle: '+ Add Portfolio Project',
                      onButtonPressed: () async {
                        final res =
                            await context.push(AppRoutes.addPortfolioProject);
                        if (res == true && context.mounted) {
                          context.read<PortfolioCubit>().loadProjects();
                        }
                      },
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return PortfolioProjectCard(
                      project: project,
                      onTap: () async {
                        final res = await context.push(
                          AppRoutes.portfolioProjectDetails,
                          extra: project,
                        );
                        if (res == true && context.mounted) {
                          context.read<PortfolioCubit>().loadProjects();
                        }
                      },
                    );
                  },
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
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
