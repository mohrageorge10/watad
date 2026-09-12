import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/bid_details_cubit.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/bid_details_state.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/widgets/accept_reject_dialogs.dart';

class BidDetailsView extends StatelessWidget {
  final String bidId;
  const BidDetailsView({super.key, required this.bidId});

  String _formatDate(String dateString) {
    if (dateString.isEmpty) return '';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy - hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BidDetailsCubit>()..fetchBidDetails(bidId),
      child: BlocConsumer<BidDetailsCubit, BidDetailsState>(
        listenWhen: (previous, current) => previous.actionState != current.actionState,
        listener: (context, state) {
          if (state.actionState == ActionState.success) {
            context.pushNamed(AppRoutes.bidResult, extra: {
              'isAccepted': state.isAccepted,
              'bidId': bidId,
            });
          } else if (state.actionState == ActionState.error) {
            AppToast.showError(context, state.actionErrorMessage);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF7FAFD), // Very light blueish background from design
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: 90.h,
              title: Container(
                margin: EdgeInsets.only(top: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: const Icon(Icons.arrow_back, color: Color(0xFF2E5BFF)),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Bid Details (Preview)',
                          style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary700),
                        ),
                      ),
                    ),
                    SizedBox(width: 24.w), // Balance for centering
                  ],
                ),
              ),
            ),
            body: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : state.errorMessage.isNotEmpty
                    ? Center(child: Text(state.errorMessage))
                    : state.bidDetails == null
                        ? const SizedBox.shrink()
                        : SingleChildScrollView(
                            padding: EdgeInsets.all(24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildContractorCard(state.bidDetails!),
                                SizedBox(height: 32.h),
                                Text('Bid Summary', style: AppTextStyles.font20SemiBold.copyWith(color: AppColors.primary700)),
                                SizedBox(height: 16.h),
                                _buildBidSummary(state.bidDetails!),
                                SizedBox(height: 32.h),
                                Text('Notes from Contractor', style: AppTextStyles.font20SemiBold.copyWith(color: AppColors.primary700)),
                                SizedBox(height: 16.h),
                                Text(
                                  state.bidDetails!.technicalProposalUrl.isNotEmpty ? state.bidDetails!.technicalProposalUrl : 'No notes provided',
                                  style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey900),
                                ),
                                SizedBox(height: 40.h), // Spacing before buttons
                              ],
                            ),
                          ),
            bottomNavigationBar: state.isLoading || state.bidDetails == null
                ? null
                : SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 24.h, top: 16.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                AcceptRejectDialogs.showRejectDialog(context, () {
                                  context.read<BidDetailsCubit>().rejectBid(bidId);
                                });
                              },
                              child: Container(
                                height: 42.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.white100,
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: AppColors.alert),
                                ),
                                child: state.actionState == ActionState.loading
                                    ? SizedBox(height: 20.h, width: 20.h, child: const CircularProgressIndicator(color: AppColors.alert))
                                    : Text(
                                        'Reject',
                                        style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.alert),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: SizedBox(
                              height:42.h,
                              child: AppElevatedButton(
                                title: 'Accept',
                                backgroundColor: AppColors.accept,
                                textStyle: AppTextStyles.btnWhite600,
                                isLoading: state.actionState == ActionState.loading,
                                onPressed: () {
                                  AcceptRejectDialogs.showAcceptDialog(context, () {
                                    context.read<BidDetailsCubit>().acceptBid(bidId);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildContractorCard(dynamic details) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grey200,
                ),
                child: Icon(Icons.person, color: AppColors.grey500, size: 24.r),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(details.contractorName, style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary700)),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, size: 14.r, color: const Color(0xFFFFB703)), // Yellow star
                      SizedBox(width: 4.w),
                      Text('4.8 (120)', style: AppTextStyles.font12MediumGrey.copyWith(color: AppColors.grey900)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone Number', style: AppTextStyles.font10MediumDark.copyWith(color: AppColors.primary700)),
                    SizedBox(height: 4.h),
                    Text(details.contractorPhoneNumber.isNotEmpty ? details.contractorPhoneNumber : '+0201029147677', style: AppTextStyles.font12MediumGrey.copyWith(color: AppColors.grey900)),
                    SizedBox(height: 12.h),
                    Text('Email', style: AppTextStyles.font10MediumDark.copyWith(color: AppColors.primary700)),
                    SizedBox(height: 4.h),
                    Text(details.contractorEmail.isNotEmpty ? details.contractorEmail : 'Ahmedmahmoud @gmail.com', style: AppTextStyles.font12MediumGrey.copyWith(color: AppColors.grey900)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Projects', style: AppTextStyles.font10MediumDark.copyWith(color: AppColors.primary700)),
                    SizedBox(height: 4.h),
                    Text('50+ Projects', style: AppTextStyles.font12MediumGrey.copyWith(color: AppColors.grey900)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBidSummary(dynamic details) {
    final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Proposed Cost', style: AppTextStyles.font14Medium.copyWith(color: AppColors.primary700)),
              Text('${currencyFormat.format(details.amount)} EGP', style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.black100, fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Proposed Duration', style: AppTextStyles.font14Medium.copyWith(color: AppColors.primary700)),
              Text('${details.durationDays} Days', style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.black100, fontWeight: FontWeight.w700)),
            ],
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Submitted At', style: AppTextStyles.font14Medium.copyWith(color: AppColors.primary700)),
              Text(_formatDate(details.submittedAt), style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.black100, fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}
