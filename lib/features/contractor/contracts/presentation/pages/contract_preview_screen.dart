import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/contracts/data/mock/mock_contract_data.dart';
import 'package:watad/features/contractor/contracts/domain/entities/contract_entity.dart';
import 'package:watad/features/contractor/contracts/presentation/cubit/contract_cubit.dart';
import 'package:watad/features/contractor/contracts/presentation/cubit/contract_state.dart';
import 'package:watad/features/contractor/contracts/presentation/view/sections/contract_details_header_section.dart';
import 'package:watad/features/contractor/contracts/presentation/view/sections/contract_preview_content_section.dart';

class ContractPreviewScreen extends StatelessWidget {
  final String? contractId;
  final ContractEntity? initialContract;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const ContractPreviewScreen({
    super.key,
    this.contractId,
    this.initialContract,
    this.onBackTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = sl<ContractCubit>();
        if (contractId != null && contractId!.isNotEmpty) {
          cubit.loadContract(contractId!);
        }
        return cubit;
      },
      child: _ContractPreviewView(
        contractId: contractId,
        initialContract: initialContract,
        onBackTap: onBackTap,
        onSettingsTap: onSettingsTap,
      ),
    );
  }
}

class _ContractPreviewView extends StatelessWidget {
  final String? contractId;
  final ContractEntity? initialContract;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const _ContractPreviewView({
    this.contractId,
    this.initialContract,
    this.onBackTap,
    this.onSettingsTap,
  });

  void _handleDashboardNavigation(BuildContext context) {
    context.go(AppRoutes.home);
  }

  void _handleDownloadPdf(BuildContext context) {
    AppToast.showSuccess(
      context,
      'Downloading ${MockContractData.previewDocumentName}...',
    );
  }

  List<ContractPartyModel> _resolveParties(ContractEntity? contract) {
    if (contract == null) return MockContractData.previewParties;

    final clientName = contract.clientName.isNotEmpty
        ? contract.clientName
        : 'Ahmed Al-Masry';
    final contractorName = contract.contractorName.isNotEmpty
        ? contract.contractorName
        : 'Al-Rayan\nConstruction';

    return [
      ContractPartyModel(
        role: 'Owner',
        name: clientName,
        isSigned: true,
        statusText: 'Signed digitally on Sep 08, 2026',
      ),
      ContractPartyModel(
        role: 'Contractor',
        name: contractorName,
        isSigned: true,
        statusText: 'Signed digitally on Sep 08,\n2026',
      ),
      const ContractPartyModel(
        role: 'Consultant (Optional)',
        name: 'Eng. Sameer El-Naggar',
        isSigned: false,
        statusText: 'Not signed',
        isUnsignedRejected: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractCubit, ContractState>(
      builder: (context, state) {
        final ContractEntity? contract = (state is ContractLoaded)
            ? state.contract
            : (state is ContractSignedSuccess)
                ? state.contract
                : initialContract;

        final title = contract?.projectName.isNotEmpty == true
            ? contract!.projectName
            : MockContractData.previewProjectTitle;

        final contractValue = contract != null
            ? 'EGP ${contract.totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
            : MockContractData.contractValue;

        final duration = contract != null
            ? '${(contract.durationDays / 30).round()} Months'
            : MockContractData.duration;

        final resolvedParties = _resolveParties(contract);

        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FA),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // 1. Header Section
                ContractDetailsHeaderSection(
                  title: 'Contract Preview',
                  onBackTap: onBackTap ??
                      () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go(AppRoutes.home);
                        }
                      },
                  onSettingsTap: onSettingsTap,
                ),

                // 2. Content Section
                ContractPreviewContentSection(
                  title: title,
                  location: MockContractData.previewLocation,
                  imageUrl: MockContractData.previewImage,
                  contractValue: contractValue,
                  startDate: MockContractData.startDate,
                  endDate: MockContractData.endDate,
                  duration: duration,
                  parties: resolvedParties,
                  terms: MockContractData.terms,
                  fileName: MockContractData.previewDocumentName,
                  fileSize: MockContractData.previewDocumentSize,
                  successMessage: MockContractData.successBannerText,
                  onDashboardTap: () => _handleDashboardNavigation(context),
                  onDownloadPdfTap: () => _handleDownloadPdf(context),
                ),
              ],
            ),
          ),
          // Detail screen: NO BottomNavigationBar
        );
      },
    );
  }
}
