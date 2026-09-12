import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/contracts/data/mock/mock_contract_data.dart';
import 'package:watad/features/contractor/contracts/presentation/view/widgets/contract_digital_signature_widget.dart';
import 'package:watad/features/contractor/contracts/presentation/view/widgets/contract_party_tile_widget.dart';
import 'package:watad/features/contractor/contracts/presentation/view/widgets/contract_project_context_card.dart';
import 'package:watad/features/contractor/contracts/presentation/view/widgets/contract_term_list_item_widget.dart';

class ContractDetailsContentSection extends StatelessWidget {
  final String projectName;
  final String contractValue;
  final String duration;
  final String startDate;
  final String endDate;
  final List<ContractPartyModel> parties;
  final List<String> terms;
  final bool isSigning;
  final bool isContractorSigned;
  final VoidCallback? onSignTap;
  final VoidCallback? onClearSignature;
  final ValueChanged<String>? onTermTap;

  const ContractDetailsContentSection({
    super.key,
    required this.projectName,
    required this.contractValue,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.parties,
    required this.terms,
    this.isSigning = false,
    this.isContractorSigned = false,
    this.onSignTap,
    this.onClearSignature,
    this.onTermTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 36.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Project Context Card
          ContractProjectContextCard(
            projectName: projectName,
            contractValue: contractValue,
            duration: duration,
            startDate: startDate,
            endDate: endDate,
          ),

          SizedBox(height: 24.h),

          // 2. Contract Parties Section
          _buildSectionHeader('Contract Parties'),
          SizedBox(height: 12.h),
          _buildPartiesCard(),

          SizedBox(height: 24.h),

          // 3. Contract Terms Section
          _buildSectionHeader('Contract Terms'),
          SizedBox(height: 12.h),
          _buildTermsCard(),

          SizedBox(height: 24.h),

          // 4. Digital Signature Section
          _buildSectionHeader('Digital Signature'),
          SizedBox(height: 12.h),
          ContractDigitalSignatureWidget(
            onClear: onClearSignature,
          ),

          SizedBox(height: 28.h),

          // 5. Action Button
          AppElevatedButton(
            title: isContractorSigned
                ? 'Contract Signed'
                : 'Sign & Accept Contract',
            height: 50,
            borderRadius: 12,
            backgroundColor: isContractorSigned
                ? AppColors.accept
                : AppColors.primary,
            isDisabled: isContractorSigned,
            isLoading: isSigning,
            onPressed: onSignTap,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1D1D1F),
      ),
    );
  }

  Widget _buildPartiesCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: parties.length,
        separatorBuilder: (_, _) => SizedBox(height: 22.h),
        itemBuilder: (context, index) {
          final party = parties[index];
          return ContractPartyTileWidget(
            role: party.role,
            name: party.name,
            isSigned: party.isSigned,
            statusText: party.statusText,
          );
        },
      ),
    );
  }

  Widget _buildTermsCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: terms.map((term) {
          return ContractTermListItemWidget(
            text: term,
            onTap: onTermTap != null ? () => onTermTap!(term) : null,
          );
        }).toList(),
      ),
    );
  }
}
