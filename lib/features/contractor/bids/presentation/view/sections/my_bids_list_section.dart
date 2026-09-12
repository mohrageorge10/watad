import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_confirmation_dialog.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/my_bids_cubit.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/my_bids_state.dart';
import 'package:watad/features/contractor/bids/presentation/view/widgets/my_bid_card_widget.dart';

class MyBidsListSection extends StatelessWidget {
  const MyBidsListSection({super.key});

  Future<void> _showWithdrawDialog(
      BuildContext context, String bidId, String title) async {
    final confirmed = await AppConfirmationDialog.show(
      context,
      title: 'Withdraw Bid',
      message:
          'Are you sure you want to withdraw your bid for "$title"? This action cannot be undone.',
      icon: Icons.delete_outline_rounded,
      iconColor: const Color(0xFFFF3B30),
      cancelText: 'Cancel',
      confirmText: 'Withdraw',
      confirmButtonColor: const Color(0xFFFF3B30),
    );

    if (confirmed && context.mounted) {
      context.read<MyBidsCubit>().withdrawBid(bidId);
      AppToast.showSuccess(
        context,
        'Bid withdrawn successfully.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyBidsCubit, MyBidsState>(
      builder: (context, state) {
        if (state is MyBidsLoading || state is MyBidsInitial) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 48.h),
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        if (state is MyBidsError) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
            child: Center(
              child: Column(
                children: [
                  Text(
                    state.message,
                    style: TextStyle(
                      color: const Color(0xFFFF3B30),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () => context.read<MyBidsCubit>().loadBids(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is MyBidsSuccess) {
          final bids = state.filteredBids;

          if (bids.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
              child: AppEmptyStateWidget(
                title: 'No Bids Found',
                message: 'No bids match the selected status filter.',
                icon: Icon(
                  Icons.article_outlined,
                  size: 64.r,
                  color: AppColors.grey400,
                ),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bids.length,
              itemBuilder: (context, index) {
                final bid = bids[index];
                return MyBidCardWidget(
                  bid: bid,
                  onTap: () {
                    context.push(
                      AppRoutes.bidDetails,
                      extra: bid,
                    );
                  },
                  onBookmarkTap: () {
                    context.read<MyBidsCubit>().toggleBookmark(bid.id);
                  },
                  onEditBidTap: () async {
                    final cubit = context.read<MyBidsCubit>();
                    final result = await context.push(
                      AppRoutes.editBid,
                      extra: bid,
                    );
                    if (result is Map<String, dynamic>) {
                      final cost = result['cost'] as String?;
                      final duration = result['duration'] as String?;
                      if (cost != null && duration != null) {
                        cubit.updateBid(
                          bid.id,
                          yourBid: cost,
                          duration: duration,
                        );
                      }
                    }
                  },
                  onWithdrawTap: () {
                    _showWithdrawDialog(context, bid.id, bid.title);
                  },
                  onViewContractTap: () {
                    context.pushNamed(
                      AppRoutes.contractDetails,
                      extra: {
                        'contractId': bid.id,
                        'bidId': bid.id,
                      },
                    );
                  },
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
