import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/cubit/contract_details_cubit.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/widgets/contract_contractor_info_card.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/widgets/contract_details_summary_card.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/widgets/contract_document_card.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/widgets/contract_download_button.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/widgets/contract_notes_card.dart';

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
      child: _ContractDetailsBody(contractId: contractId),
    );
  }
}

class _ContractDetailsBody extends StatelessWidget {
  final String contractId;

  const _ContractDetailsBody({required this.contractId});

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
              AppToast.showInfo(context, 'Preparing and downloading contract...');
            } else if (state is ContractPdfSuccess) {
              AppToast.showSuccess(
                context,
                'Contract downloaded and opened successfully',
              );
            } else if (state is ContractPdfError) {
              AppToast.showError(context, state.message);
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
                  context.read<ContractDetailsCubit>().fetchContractDetails(contractId);
                },
              );
            } else if (state is ContractDetailsSuccess) {
              final contract = state.contractDetails;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  children: [
                    const ContractContractorInfoCard(),
                    SizedBox(height: 16.h),
                    ContractDetailsSummaryCard(contract: contract),
                    SizedBox(height: 16.h),
                    if (contract.contractPdfUrl != null &&
                        contract.contractPdfUrl!.isNotEmpty)
                      ContractDocumentCard(
                        pdfUrl: contract.contractPdfUrl!,
                        onDownloadTap: () {
                          context
                              .read<ContractDetailsCubit>()
                              .generateAndDownloadPdf(
                                contract.projectId.toString(),
                                contract.id.toString(),
                              );
                        },
                      ),
                    SizedBox(height: 16.h),
                    ContractNotesCard(terms: contract.termsAndConditions),
                    SizedBox(height: 32.h),
                    ContractDownloadButton(contract: contract),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

