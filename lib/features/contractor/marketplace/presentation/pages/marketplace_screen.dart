import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_state.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_bottom_nav_bar.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_entity.dart';
import 'package:watad/features/contractor/marketplace/presentation/cubit/marketplace_cubit.dart';
import 'package:watad/features/contractor/marketplace/presentation/cubit/marketplace_state.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_filter_chips_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_header_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_projects_list_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_search_filter_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_shimmer_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/marketplace_budget_filter_bottom_sheet.dart';
import 'package:watad/features/contractor/profile/data/datasources/contractor_profile_remote_data_source.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';

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
  List<String> _userGovernorates = ['Cairo', 'Giza'];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _loadUserGovernorates();
  }

  void _loadUserGovernorates() {
    // 1. Check local cache first
    try {
      if (sl.isRegistered<CacheHelper>()) {
        final raw = sl<CacheHelper>().getData(key: 'contractor_cached_governorates') as String?;
        if (raw != null && raw.isNotEmpty) {
          final decoded = jsonDecode(raw);
          if (decoded is List && decoded.isNotEmpty) {
            final list = decoded
                .map((e) => e.toString().trim())
                .where((s) => s.isNotEmpty)
                .toList();
            if (list.isNotEmpty) {
              _userGovernorates = list;
            }
          }
        }
      }
    } catch (_) {}

    // 2. Check ContractorProfileCubit state if active
    try {
      if (sl.isRegistered<ContractorProfileCubit>()) {
        final profileState = sl<ContractorProfileCubit>().state;
        if (profileState is ContractorProfileSuccess &&
            profileState.profile.coveredGovernorates.isNotEmpty) {
          _userGovernorates = profileState.profile.coveredGovernorates;
        }
      }
    } catch (_) {}

    // 3. Fetch from remote data source to always have latest profile locations
    Future.microtask(() async {
      try {
        if (sl.isRegistered<ContractorProfileRemoteDataSource>()) {
          final profile = await sl<ContractorProfileRemoteDataSource>()
              .fetchContractorProfile();
          if (profile.coveredGovernorates.isNotEmpty && mounted) {
            setState(() {
              _userGovernorates = profile.coveredGovernorates;
            });
          }
        }
      } catch (_) {}
    });
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
    MarketplaceBudgetFilterBottomSheet.show(
      context,
      initialBudget: cubit.currentMinBudget,
      currentCategory: cubit.currentCategory,
      availableGovernorates: _userGovernorates,
      onApply: (category, minBudget) {
        if (category != cubit.currentCategory) {
          cubit.selectFilterChip(category);
        }
        cubit.setBudgetFilter(minBudget);
      },
      onReset: () {
        cubit.clearFilters();
      },
    );
  }

  String _formatChipBudget(int amount) {
    if (amount >= 1000000) {
      final m = amount / 1000000;
      return m % 1 == 0 ? '${m.toInt()}M' : '${m.toStringAsFixed(1)}M';
    }
    return '${(amount / 1000).toInt()}K';
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

            // Search & Filter Section (Floating over blue header)
            Transform.translate(
              offset: Offset(0, -24.h),
              child: MarketplaceSearchFilterSection(
                searchController: _searchController,
                onSearchChanged: (query) {
                  context.read<MarketplaceCubit>().searchProjects(query);
                },
                onClearSearch: () {
                  context.read<MarketplaceCubit>().searchProjects('');
                },
                onFilterTap: () => _handleFilterTap(context),
              ),
            ),

            // Filter Chips Section
            Transform.translate(
              offset: Offset(0, -12.h),
              child: BlocBuilder<MarketplaceCubit, MarketplaceState>(
                builder: (context, state) {
                  final activeChip = state is MarketplaceSuccess
                      ? state.activeChip
                      : state is MarketplaceEmpty
                          ? state.activeChip
                          : state is MarketplaceLoading
                              ? state.activeChip
                              : context.read<MarketplaceCubit>().currentCategory;

                  final minBudget = state is MarketplaceSuccess
                      ? state.minBudget
                      : state is MarketplaceEmpty
                          ? state.minBudget
                          : state is MarketplaceLoading
                              ? state.minBudget
                              : context.read<MarketplaceCubit>().currentMinBudget;

                  final isBudgetActive = minBudget != null && minBudget > 0;
                  final budgetLabel = isBudgetActive
                      ? 'Budget (${_formatChipBudget(minBudget)}+)'
                      : 'Budget';

                  final chipList = <FilterChipData>[
                    FilterChipData(
                      label: 'All',
                      isSelected: activeChip == 'All' && !isBudgetActive,
                    ),
                    ..._userGovernorates.map(
                      (gov) => FilterChipData(
                        label: gov,
                        isSelected: activeChip == gov,
                      ),
                    ),
                    FilterChipData(
                      label: budgetLabel,
                      icon: Icons.tune_rounded,
                      isSelected: isBudgetActive || activeChip == 'Budget',
                    ),
                  ];

                  return MarketplaceFilterChipsSection(
                    activeChip: activeChip,
                    chips: chipList,
                    onChipSelected: (chip) {
                      if (chip.startsWith('Budget')) {
                        _handleFilterTap(context);
                      } else {
                        context.read<MarketplaceCubit>().selectFilterChip(chip);
                      }
                    },
                  );
                },
              ),
            ),

            // Projects List or Shimmer / Empty State
            Transform.translate(
              offset: Offset(0, -12.h),
              child: BlocBuilder<MarketplaceCubit, MarketplaceState>(
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
                      context.read<MarketplaceCubit>().clearFilters();
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
            ),
          ],
        ),
      ),
    );
  }
}
