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
import 'package:watad/features/contractor/contracts/presentation/view/sections/contract_details_content_section.dart';
import 'package:watad/features/contractor/contracts/presentation/view/sections/contract_details_header_section.dart';

class ContractDetailsSignScreen extends StatelessWidget {
  final String? contractId;
  final String? bidId;
  final ContractEntity? initialContract;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const ContractDetailsSignScreen({
    super.key,
    this.contractId,
    this.bidId,
    this.initialContract,
    this.onBackTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = sl<ContractCubit>();
        if (bidId != null && bidId!.isNotEmpty) {
          cubit.loadContractByBid(bidId!);
        } else if (contractId != null && contractId!.isNotEmpty) {
          cubit.loadContract(contractId!);
        }
        return cubit;
      },
      child: _ContractDetailsSignView(
        contractId: contractId,
        bidId: bidId,
        initialContract: initialContract,
        onBackTap: onBackTap,
        onSettingsTap: onSettingsTap,
      ),
    );
  }
}

class _ContractDetailsSignView extends StatefulWidget {
  final String? contractId;
  final String? bidId;
  final ContractEntity? initialContract;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;

  const _ContractDetailsSignView({
    this.contractId,
    this.bidId,
    this.initialContract,
    this.onBackTap,
    this.onSettingsTap,
  });

  @override
  State<_ContractDetailsSignView> createState() =>
      _ContractDetailsSignViewState();
}

class _ContractDetailsSignViewState extends State<_ContractDetailsSignView> {
  late List<ContractPartyModel> _parties;
  bool _isContractorSigned = false;

  @override
  void initState() {
    super.initState();
    _parties = List.from(MockContractData.parties);
  }

  void _handleSignContract(BuildContext context) {
    final cubit = context.read<ContractCubit>();
    cubit.signCurrentContract(
      contractId: widget.contractId ?? widget.bidId,
      digitalSignature: 'signed_hash_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  void _handleClearSignature() {
    AppToast.showInfo(context, 'Signature area cleared.');
  }

  void _handleTermTap(String term) {
    AppToast.showInfo(context, 'Viewing $term');
  }

  List<ContractPartyModel> _resolveParties(ContractEntity? contract) {
    if (contract == null) return _parties;

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
        isSigned: contract.isContractorSigned || _isContractorSigned,
        statusText: (contract.isContractorSigned || _isContractorSigned)
            ? 'Signed digitally on Sep 08,\n2026'
            : 'Not signed',
      ),
      const ContractPartyModel(
        role: 'Consultant (Optional)',
        name: 'Eng. Sameer El-Naggar',
        isSigned: false,
        statusText: 'Not signed',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContractCubit, ContractState>(
      listener: (context, state) {
        if (state is ContractSignedSuccess) {
          AppToast.showSuccess(context, state.message);
          setState(() {
            _isContractorSigned = true;
          });
          Future.delayed(const Duration(milliseconds: 600), () {
            if (context.mounted) {
              context.pushNamed(
                AppRoutes.contractPreview,
                extra: {
                  'contract': state.contract,
                  'contractId': state.contract.id,
                },
              );
            }
          });
        } else if (state is ContractError) {
          AppToast.showError(context, state.message);
        }
      },
      builder: (context, state) {
        final isSigning = state is ContractSigning;

        // Use real contract if loaded, otherwise fallback to mock data
        final ContractEntity? contract = (state is ContractLoaded)
            ? state.contract
            : (state is ContractSignedSuccess)
                ? state.contract
                : widget.initialContract;

        final projectName = contract?.projectName.isNotEmpty == true
            ? contract!.projectName
            : MockContractData.projectName;

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
                  title: 'Contract Details & Sign',
                  onBackTap: widget.onBackTap ??
                      () {
                        if (context.canPop()) {
                          context.pop();
                        }
                      },
                  onSettingsTap: widget.onSettingsTap,
                ),

                // 2. Content Section
                ContractDetailsContentSection(
                  projectName: projectName,
                  contractValue: contractValue,
                  duration: duration,
                  startDate: MockContractData.startDate,
                  endDate: MockContractData.endDate,
                  parties: resolvedParties,
                  terms: MockContractData.terms,
                  isSigning: isSigning,
                  isContractorSigned: _isContractorSigned ||
                      (contract?.isContractorSigned == true),
                  onSignTap: () => _handleSignContract(context),
                  onClearSignature: _handleClearSignature,
                  onTermTap: _handleTermTap,
                ),
              ],
            ),
          ),
          // Sub-screen: NO BottomNavigationBar
        );
      },
    );
  }
}
