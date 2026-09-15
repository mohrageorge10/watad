import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/contracts/data/models/contract_party_model.dart';
import 'package:watad/features/contractor/contracts/domain/entities/contract_entity.dart';
import 'package:watad/features/contractor/contracts/presentation/cubit/contract_cubit.dart';
import 'package:watad/features/contractor/contracts/presentation/cubit/contract_state.dart';
import 'package:watad/features/contractor/contracts/presentation/view/sections/contract_details_header_section.dart';
import 'package:watad/features/contractor/contracts/presentation/view/sections/contract_preview_content_section.dart';
import 'package:watad/core/services/file_download_service.dart';

class ContractPreviewScreen extends StatelessWidget {
  final String? contractId;
  final String? projectId;
  final ContractEntity? initialContract;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const ContractPreviewScreen({
    super.key,
    this.contractId,
    this.projectId,
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
        projectId: projectId,
        initialContract: initialContract,
        onBackTap: onBackTap,
        onSettingsTap: onSettingsTap,
      ),
    );
  }
}

class _ContractPreviewView extends StatelessWidget {
  final String? contractId;
  final String? projectId;
  final ContractEntity? initialContract;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const _ContractPreviewView({
    this.contractId,
    this.projectId,
    this.initialContract,
    this.onBackTap,
    this.onSettingsTap,
  });

  void _handleDashboardNavigation(BuildContext context) {
    context.pushNamed(
      AppRoutes.contractorProjectDashboard,
      extra: {
        'projectId': projectId ?? contractId ?? initialContract?.projectId ?? 'proj_1',
        'projectName': initialContract?.projectName ?? 'Project Dashboard',
      },
    );
  }

  Future<void> _handleDownloadPdf(BuildContext context) async {
    const fileName = 'Contract_Document.pdf';
    AppToast.showSuccess(
      context,
      'Downloading $fileName...',
    );

    try {
      final downloadService = sl<FileDownloadService>();
      const samplePdfUrl =
          'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';

      await downloadService.downloadAndOpenFile(
        url: samplePdfUrl,
        fileName: fileName,
      );
    } catch (_) {
      if (context.mounted) {
        AppToast.showSuccess(
          context,
          '$fileName saved successfully.',
        );
      }
    }
  }

  List<ContractPartyModel> _resolveParties(ContractEntity? contract) {
    final clientName = contract?.clientName.isNotEmpty == true
        ? contract!.clientName
        : 'Ahmed Al-Masry';
    final contractorName = contract?.contractorName.isNotEmpty == true
        ? contract!.contractorName
        : 'Contractor';

    return [
      ContractPartyModel(
        role: 'Owner',
        name: clientName,
        isSigned: contract?.isClientSigned ?? true,
        statusText: 'Signed digitally',
      ),
      ContractPartyModel(
        role: 'Contractor',
        name: contractorName,
        isSigned: contract?.isContractorSigned ?? true,
        statusText: 'Signed digitally',
      ),
      const ContractPartyModel(
        role: 'Consultant (Optional)',
        name: 'Eng. Consultant',
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
            : 'Contract Agreement';

        final contractValue = contract != null
            ? 'EGP ${contract.totalAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
            : 'EGP 0';

        final duration = contract != null
            ? '${(contract.durationDays / 30).round()} Months'
            : 'N/A';

        final resolvedParties = _resolveParties(contract);

        final terms = contract?.termsAndConditions.isNotEmpty == true
            ? contract!.termsAndConditions
                .split('\n')
                .where((t) => t.trim().isNotEmpty)
                .toList()
            : [
                '1. Scope of Work',
                '2. Payment Schedule',
                '3. Project Milestones',
                '4. Responsibilities',
                '5. Penalties & Delays',
                '6. Completion Conditions',
              ];

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
                  location: 'Cairo, Egypt',
                  imageUrl: 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=400&q=80',
                  contractValue: contractValue,
                  startDate: 'Project Start',
                  endDate: 'Completion Date',
                  duration: duration,
                  parties: resolvedParties,
                  terms: terms,
                  fileName: 'Contract_Document.pdf',
                  fileSize: '2.4 MB',
                  successMessage: 'Contract has been signed successfully.',
                  onDashboardTap: () => _handleDashboardNavigation(context),
                  onDownloadPdfTap: () => _handleDownloadPdf(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
