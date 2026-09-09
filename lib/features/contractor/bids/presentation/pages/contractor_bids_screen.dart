import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/contractor_bids_cubit.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/contractor_bids_state.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/project_card_widget.dart';

class ContractorBidsScreen extends StatelessWidget {
  final bool showBackButton;

  const ContractorBidsScreen({
    super.key,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContractorBidsCubit>()..loadFirstPage(),
      child: _ContractorBidsView(showBackButton: showBackButton),
    );
  }
}

class _ContractorBidsView extends StatefulWidget {
  final bool showBackButton;

  const _ContractorBidsView({required this.showBackButton});

  @override
  State<_ContractorBidsView> createState() => _ContractorBidsViewState();
}

class _ContractorBidsViewState extends State<_ContractorBidsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // Trigger next page when within 200px of bottom
    if (currentScroll >= maxScroll - 200) {
      context.read<ContractorBidsCubit>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        leading: widget.showBackButton
            ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.white100,
                  size: 20.r,
                ),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              )
            : null,
        title: Text(
          'Contractor Bids',
          style: TextStyle(
            color: AppColors.white100,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<ContractorBidsCubit, ContractorBidsState>(
        builder: (context, state) {
          // 1. Initial / Loading first page
          if (state is ContractorBidsLoading || state is ContractorBidsInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          // 2. Error State
          if (state is ContractorBidsError) {
            return Center(
              child: AppEmptyStateWidget(
                title: 'Unable to Load Bids',
                message: state.message,
                buttonTitle: 'Try Again',
                onButtonPressed: () {
                  context.read<ContractorBidsCubit>().loadFirstPage();
                },
              ),
            );
          }

          // 3. Empty State
          if (state is ContractorBidsEmpty) {
            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () => context.read<ContractorBidsCubit>().refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: AppEmptyStateWidget(
                      title: 'No Bids Submitted',
                      message:
                          'Browse open marketplace tenders to submit your first project quotation.',
                      buttonTitle: 'Refresh',
                      onButtonPressed: () {
                        context.read<ContractorBidsCubit>().loadFirstPage();
                      },
                    ),
                  ),
                ),
              ),
            );
          }

          // 4. Success State with Infinite Scroll
          if (state is ContractorBidsSuccess) {
            final bids = state.bids;
            final bool isLoadingMore = state.isLoadingMore;

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () => context.read<ContractorBidsCubit>().refresh(),
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                itemCount: bids.length + (isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  // If reaching the end while loading next page, render bottom spinner
                  if (index == bids.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2.5,
                        ),
                      ),
                    );
                  }

                  final bid = bids[index];
                  return ProjectCardWidget(
                    title: bid.title,
                    location: bid.location,
                    timeOrAmount: bid.amount,
                    badgeText: bid.badgeText,
                    badgeColorHex: bid.badgeColorHex,
                    progress: null,
                    imagePath: bid.image,
                    onTap: () {
                      // Handle individual bid tap
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
