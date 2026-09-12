import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_bottom_nav_bar.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';
import 'package:watad/features/contractor/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:watad/features/contractor/marketplace/presentation/cubit/marketplace_state.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_filter_chips_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_header_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_projects_list_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_search_filter_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_shimmer_section.dart';

class MarketplaceScreen extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final ValueChanged<MarketplaceProjectEntity>? onProjectTap;
  final ValueChanged<MarketplaceProjectEntity>? onViewDetailsTap;
  final bool showBottomNavBar;

  const MarketplaceScreen({
    super.key,
    this.onBackTap,
    this.onSettingsTap,
    this.onProjectTap,
    this.onViewDetailsTap,
    this.showBottomNavBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MarketplaceCubit>()..loadProjects(),
      child: _MarketplaceView(
        onBackTap: onBackTap,
        onSettingsTap: onSettingsTap,
        onProjectTap: onProjectTap,
        onViewDetailsTap: onViewDetailsTap,
        showBottomNavBar: showBottomNavBar,
      ),
    );
  }
}

class _MarketplaceView extends StatefulWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final ValueChanged<MarketplaceProjectEntity>? onProjectTap;
  final ValueChanged<MarketplaceProjectEntity>? onViewDetailsTap;
  final bool showBottomNavBar;

  const _MarketplaceView({
    this.onBackTap,
    this.onSettingsTap,
    this.onProjectTap,
    this.onViewDetailsTap,
    required this.showBottomNavBar,
  });

  @override
  State<_MarketplaceView> createState() => _MarketplaceViewState();
}

class _MarketplaceViewState extends State<_MarketplaceView> {
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

  void _handleBottomNavTap(BuildContext context, int index) {
    if (index == 1) return; // Current tab

    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 2:
        context.push(AppRoutes.myProjects);
        break;
      case 3:
        context.push(AppRoutes.myBids);
        break;
      case 4:
        context.push(AppRoutes.contractorProfile);
        break;
    }
  }

  void _handleFilterTap(BuildContext context) {
    final cubit = context.read<MarketplaceCubit>();
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) {
        Widget buildOption({
          required IconData icon,
          required String title,
          required String chipValue,
        }) {
          final isSelected = cubit.currentCategory == chipValue;
          return ListTile(
            leading: Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.grey500,
              size: 22.r,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.grey900,
              ),
            ),
            trailing: isSelected
                ? Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.primary,
                    size: 20.r,
                  )
                : null,
            onTap: () {
              cubit.selectFilterChip(chipValue);
              Navigator.pop(bottomSheetContext);
            },
          );
        }

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Filter by Location & Budget',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.grey900,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      splashRadius: 20.r,
                      onPressed: () => Navigator.pop(bottomSheetContext),
                    ),
                  ],
                ),
                const Divider(),
                buildOption(
                  icon: Icons.location_city_rounded,
                  title: 'All Locations',
                  chipValue: 'All',
                ),
                buildOption(
                  icon: Icons.pin_drop_outlined,
                  title: 'Cairo Only',
                  chipValue: 'Cairo',
                ),
                buildOption(
                  icon: Icons.pin_drop_outlined,
                  title: 'Giza Only',
                  chipValue: 'Giza',
                ),
                buildOption(
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'Sort by Budget (Lowest First)',
                  chipValue: 'Budget',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleViewDetails(
      BuildContext context, MarketplaceProjectEntity project) {
    if (widget.onViewDetailsTap != null) {
      widget.onViewDetailsTap!(project);
    } else {
      context.push(AppRoutes.marketplaceProjectDetails, extra: project);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      bottomNavigationBar: widget.showBottomNavBar
          ? ContractorBottomNavBar(
              currentIndex: 1,
              onTap: (index) => _handleBottomNavTap(context, index),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section without back button
            MarketplaceHeaderSection(
              onBackTap: widget.onBackTap,
              onSettingsTap: widget.onSettingsTap,
              title: 'Marketplace',
              showBackButton: false,
            ),

            // Search & Filter Section
            MarketplaceSearchFilterSection(
              searchController: _searchController,
              onSearchChanged: (query) {
                context.read<MarketplaceCubit>().searchProjects(query);
              },
              onClearSearch: () {
                context.read<MarketplaceCubit>().searchProjects('');
              },
              onFilterTap: () => _handleFilterTap(context),
            ),

            // Filter Chips Section
            BlocBuilder<MarketplaceCubit, MarketplaceState>(
              builder: (context, state) {
                final activeChip = state is MarketplaceSuccess
                    ? state.activeChip
                    : state is MarketplaceEmpty
                        ? state.activeChip
                        : state is MarketplaceLoading
                            ? state.activeChip
                            : context.read<MarketplaceCubit>().currentCategory;

                return MarketplaceFilterChipsSection(
                  activeChip: activeChip,
                  onChipSelected: (chip) {
                    context.read<MarketplaceCubit>().selectFilterChip(chip);
                  },
                );
              },
            ),

            // Projects List or Shimmer / Empty State
            BlocBuilder<MarketplaceCubit, MarketplaceState>(
              builder: (context, state) {
                if (state is MarketplaceLoading ||
                    state is MarketplaceInitial) {
                  return const MarketplaceShimmerSection();
                }

                if (state is MarketplaceEmpty) {
                  return AppEmptyStateWidget(
                    title: 'No Projects Found',
                    message: state.message,
                    buttonTitle: 'Reset Filter',
                    onButtonPressed: () {
                      _searchController.clear();
                      context.read<MarketplaceCubit>().selectFilterChip('All');
                    },
                  );
                }

                if (state is MarketplaceError) {
                  return AppEmptyStateWidget(
                    title: 'Error Loading Projects',
                    message: state.message,
                    buttonTitle: 'Try Again',
                    onButtonPressed: () {
                      context.read<MarketplaceCubit>().loadProjects();
                    },
                  );
                }

                if (state is MarketplaceSuccess) {
                  return MarketplaceProjectsListSection(
                    projects: state.projects,
                    onProjectTap: (project) {
                      if (widget.onProjectTap != null) {
                        widget.onProjectTap!(project);
                      } else {
                        _handleViewDetails(context, project);
                      }
                    },
                    onViewDetailsTap: (project) =>
                        _handleViewDetails(context, project),
                    onBookmarkTap: (id) {
                      context.read<MarketplaceCubit>().toggleBookmark(id);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
