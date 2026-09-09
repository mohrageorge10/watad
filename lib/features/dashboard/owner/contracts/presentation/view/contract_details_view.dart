import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/cubit/contract_details_cubit.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/features/dashboard/owner/contracts/data/models/contract_details_dto.dart';

class ContractDetailsView extends StatelessWidget {
  final String contractId;

  const ContractDetailsView({
    super.key,
    required this.contractId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContractDetailsCubit>()..fetchContractDetails(contractId),
      child: const _ContractDetailsBody(),
    );
  }
}

class _ContractDetailsBody extends StatelessWidget {
  const _ContractDetailsBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white100,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Contract Details',
          style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
          side: const BorderSide(color: AppColors.grey200),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ContractDetailsCubit, ContractDetailsState>(
          listener: (context, state) {
            if (state is ContractPdfLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Preparing and downloading contract...')),
              );
            } else if (state is ContractPdfSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Contract downloaded and opened successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is ContractPdfError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          buildWhen: (previous, current) {
            // Only rebuild the main body if we are changing the main contract details state
            return current is ContractDetailsLoading || current is ContractDetailsError || current is ContractDetailsSuccess;
          },
          builder: (context, state) {
            if (state is ContractDetailsLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            } else if (state is ContractDetailsError) {
              return AppEmptyStateWidget(
                title: 'Error',
                message: state.message,
                buttonTitle: 'Retry',
                onButtonPressed: () {
                  // context.read<ContractDetailsCubit>().fetchContractDetails(contractId);
                },
              );
            } else if (state is ContractDetailsSuccess) {
              final contract = state.contractDetails;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  children: [
                    _buildContractorCard(),
                    SizedBox(height: 16.h),
                    _buildDetailsContainer(contract),
                    SizedBox(height: 16.h),
                    if (contract.contractPdfUrl != null && contract.contractPdfUrl!.isNotEmpty)
                      _buildDocumentCard(contract.contractPdfUrl!),
                    SizedBox(height: 16.h),
                    _buildNotesCard(contract.termsAndConditions),
                    SizedBox(height: 32.h),
                    _buildViewFullContractButton(context, contract),
                  ],
                ),
              );
            }
            // If the state is ContractPdfLoading/Success/Error, the builder should return the UI from the previous state.
            // Since we use buildWhen, this should generally not hit, but we can return the cached UI if needed.
            // However, a simple approach is to get the current contract from the cubit or just rebuild properly.
            // Actually, if we use buildWhen, the builder is NOT called for Pdf states, so it keeps the previous widget!
            // But what if it does get called on first build? state is Initial.
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildContractorCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.grey200),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.r,
            backgroundImage: const AssetImage('assets/images/logo.png'), // placeholder
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BuildPro Construction',
                  style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.primary),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.accent, size: 14),
                    SizedBox(width: 4.w),
                    Text(
                      '4.8 (120)',
                      style: AppTextStyles.font12RegularGrey,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.phone_outlined, color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildDetailsContainer(ContractDetailsDto contract) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.grey200),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey300.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(Icons.description_outlined, 'Contract No.', 'CTR-${contract.id.substring(0, 8).toUpperCase()}'),
          _buildDivider(),
          _buildDetailRow(Icons.description_outlined, 'Contract Terms', contract.termsAndConditions?.isNotEmpty == true ? 'Custom Terms' : 'Standard Terms'),
          _buildDivider(),
          _buildDetailRow(Icons.dashboard_customize_outlined, 'Payment Milestones', '${contract.milestones.length} Milestones Defined'),
          _buildDivider(),
          _buildDetailRow(Icons.calendar_today_outlined, 'Start Date', contract.startDate),
          _buildDivider(),
          _buildDetailRow(Icons.calendar_today_outlined, 'End Date', contract.endDate),
          _buildDivider(),
          _buildDetailRow(Icons.monetization_on_outlined, 'Total Contract Value (EGP)', '${contract.totalValue} EGP', isBoldValue: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value, {bool isBoldValue = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.grey400, size: 18),
          SizedBox(width: 8.w),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey500),
              softWrap: true,
            ),
          ),
          SizedBox(width: 8.w),
          Flexible(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: isBoldValue
                  ? AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.primary)
                  : AppTextStyles.font14Medium.copyWith(color: AppColors.primary),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: const Divider(color: AppColors.grey200, thickness: 1),
    );
  }

  Widget _buildDocumentCard(String pdfUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.edit_document, color: AppColors.primary, size: 18),
            SizedBox(width: 8.w),
            Text(
              'Contract Document',
              style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.grey200),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.alert,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text('PDF', style: AppTextStyles.font10MediumWhite),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'contract_villa_newcairo.pdf',
                      style: AppTextStyles.font14SemiBoldDark,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '2.4 MB',
                      style: AppTextStyles.font12RegularGrey,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.download_outlined, color: AppColors.primary),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotesCard(String? terms) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.note_alt_outlined, color: AppColors.primary, size: 18),
            SizedBox(width: 8.w),
            Text(
              'Notes',
              style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.grey200),
          ),
          child: Text(
            terms ?? 'Contract for construction works as per project scope.',
            style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey500),
          ),
        ),
      ],
    );
  }

  Widget _buildViewFullContractButton(BuildContext context, ContractDetailsDto contract) {
    return BlocBuilder<ContractDetailsCubit, ContractDetailsState>(
      buildWhen: (previous, current) => 
          current is ContractPdfLoading || current is ContractPdfSuccess || current is ContractPdfError,
      builder: (context, state) {
        final isLoading = state is ContractPdfLoading;
        return ElevatedButton(
          onPressed: isLoading ? null : () {
            context.read<ContractDetailsCubit>().generateAndDownloadPdf(
              contract.projectId.toString(), 
              contract.id.toString(),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: Size(double.infinity, 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: isLoading 
              ? const SizedBox(
                  width: 24, 
                  height: 24, 
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.white100)
                )
              : Text(
                  'Download Contract PDF',
                  style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.white100),
                ),
        );
      }
    );
  }
}
