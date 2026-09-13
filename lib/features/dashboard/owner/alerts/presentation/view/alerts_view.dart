import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';

import '../cubit/alerts_cubit.dart';
import '../cubit/alerts_state.dart';
import '../widgets/alert_card.dart';
import '../widgets/alert_category_chips.dart';

class AlertsView extends StatefulWidget {
  const AlertsView({super.key});

  @override
  State<AlertsView> createState() => _AlertsViewState();
}

class _AlertsViewState extends State<AlertsView> {
  late AlertsCubit _cubit;
  final ScrollController _scrollController = ScrollController();

  final Map<String, String> _categoryOptions = {
    'General': 'General',
    'Quality & Risk': 'QualityAndRisk',
    'Schedule': 'Schedule',
    'Material & Waste': 'MaterialAndWaste',
    'Change Order': 'ChangeOrder',
    'Site Log': 'SiteLog',
    'Inspection': 'Inspection',
    'Financial': 'Financial',
  };

  final Map<String, String> _typeOptions = {
    'Info': 'Info',
    'Warning': 'Warning',
    'Alert': 'Alert',
    'Action Required': 'ActionRequired',
  };

  @override
  void initState() {
    super.initState();
    _cubit = sl<AlertsCubit>()..fetchAlerts();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: AppColors.secondBackground,
        body: SafeArea(
          child: Column(
            children: [
              // Custom Header
              Container(
                margin: EdgeInsets.all(24.w).copyWith(bottom: 16.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(Icons.arrow_back, color: AppColors.primary),
                    ),
                    Expanded(
                      child: Text(
                        "Alerts",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font16SemiBold.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 24.w),
                  ],
                ),
              ),

              // Content Area
              Expanded(
                child: BlocBuilder<AlertsCubit, AlertsState>(
                  builder: (context, state) {
                    if (state is AlertsInitial || (state is AlertsLoading && _cubit.state is! AlertsLoaded)) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                    } else if (state is AlertsError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Error: ${state.message}",
                              style: AppTextStyles.font14Medium.copyWith(color: AppColors.alert),
                            ),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              onPressed: () => _cubit.fetchAlerts(
                                category: state.activeCategory,
                                type: state.activeType,
                                isRefresh: true,
                              ),
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                              child: Text(
                                "Retry",
                                style: AppTextStyles.font14Medium.copyWith(color: AppColors.white100),
                              ),
                            )
                          ],
                        ),
                      );
                    } else if (state is AlertsLoaded) {
                      final activeTypeUI = _typeOptions.entries
                          .firstWhere((e) => e.value == state.activeType, orElse: () => const MapEntry('Info', 'Info'))
                          .key;

                      return Column(
                        children: [
                          // Filter Chips
                          AlertCategoryChips(
                            categories: _typeOptions.keys.toList(),
                            activeCategory: state.activeType == null ? '' : activeTypeUI,
                            onCategorySelected: (typeLabel) {
                              if (state.activeType == _typeOptions[typeLabel]) {
                                _cubit.filterType(null); // toggle off
                              } else {
                                _cubit.filterType(_typeOptions[typeLabel]);
                              }
                            },
                          ),
                          SizedBox(height: 24.h),

                          // Scrollable Alerts List
                          Expanded(
                            child: CustomScrollView(
                              controller: _scrollController,
                              slivers: [
                                SliverPadding(
                                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                                  sliver: SliverToBoxAdapter(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Recent",
                                          style: AppTextStyles.font14SemiBoldDark.copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          onSelected: (String? value) {
                                            _cubit.filterCategory(value == 'All' ? null : value);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                            decoration: BoxDecoration(
                                              color: AppColors.white100,
                                              borderRadius: BorderRadius.circular(20.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withValues(alpha: 0.04),
                                                  blurRadius: 4,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                Text(
                                                  state.activeCategory != null 
                                                    ? _categoryOptions.entries.firstWhere((e) => e.value == state.activeCategory).key 
                                                    : "Sort By Category",
                                                  style: AppTextStyles.font12MediumGrey.copyWith(
                                                    color: AppColors.primary,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(width: 4.w),
                                                Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 16.sp),
                                              ],
                                            ),
                                          ),
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              const PopupMenuItem<String>(
                                                value: 'All',
                                                child: Text('All Categories'),
                                              ),
                                              ..._categoryOptions.entries.map((e) {
                                                return PopupMenuItem<String>(
                                                  value: e.value,
                                                  child: Text(e.key),
                                                );
                                              }),
                                            ];
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (state.data.items.isEmpty)
                                  const SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: AppEmptyStateWidget(
                                      title: 'No notifications found',
                                      message: 'You currently have no notifications for this category.',
                                    ),
                                  )
                                else
                                  SliverPadding(
                                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                          if (index == state.data.items.length) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(vertical: 16.h),
                                              child: const Center(
                                                child: CircularProgressIndicator(color: AppColors.primary),
                                              ),
                                            );
                                          }
                                          return AlertCard(alert: state.data.items[index]);
                                        },
                                        childCount: state.data.items.length + (state.isFetchingMore ? 1 : 0),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

