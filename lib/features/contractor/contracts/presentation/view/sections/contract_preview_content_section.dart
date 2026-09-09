import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/contracts/data/mock/mock_contract_data.dart';
import 'package:watad/features/contractor/contracts/presentation/view/widgets/contract_overview_card.dart';
import 'package:watad/features/contractor/contracts/presentation/view/widgets/contract_party_tile_widget.dart';
import 'package:watad/features/contractor/contracts/presentation/view/widgets/contract_project_summary_card.dart';
import 'package:watad/features/contractor/contracts/presentation/view/widgets/contract_success_banner.dart';
import 'package:watad/features/contractor/contracts/presentation/view/widgets/contract_terms_attachment_card.dart';

class ContractPreviewContentSection extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final String contractValue;
  final String startDate;
  final String endDate;
  final String duration;
  final List<ContractPartyModel> parties;
  final List<String> terms;
  final String fileName;
  final String fileSize;
  final String successMessage;
  final VoidCallback? onDashboardTap;
  final VoidCallback? onDownloadPdfTap;

  const ContractPreviewContentSection({
    super.key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.contractValue,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.parties,
    required this.terms,
    required this.fileName,
    required this.fileSize,
    required this.successMessage,
    this.onDashboardTap,
    this.onDownloadPdfTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 36.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Project Summary Card
          ContractProjectSummaryCard(
            title: title,
            location: location,
            imageUrl: imageUrl,
          ),

          SizedBox(height: 24.h),

          // 2. Contract Overview Section
          _buildSectionHeader('Contract Overview'),
          SizedBox(height: 12.h),
          ContractOverviewCard(
            contractValue: contractValue,
            startDate: startDate,
            endDate: endDate,
            duration: duration,
          ),

          SizedBox(height: 24.h),

          // 3. Contract Parties Section
          _buildSectionHeader('Contract Parties'),
          SizedBox(height: 12.h),
          _buildPartiesCard(),

          SizedBox(height: 24.h),

          // 4. Terms & Conditions Section
          _buildSectionHeader('Terms & Conditions'),
          SizedBox(height: 12.h),
          ContractTermsDropdownCard(
            terms: terms,
          ),
          SizedBox(height: 12.h),
          ContractAttachmentCard(
            fileName: fileName,
            fileSize: fileSize,
            onDownload: onDownloadPdfTap,
          ),

          SizedBox(height: 24.h),

          // 5. Success Banner
          ContractSuccessBanner(
            text: successMessage,
          ),

          SizedBox(height: 24.h),

          // 6. Action Button
          AppElevatedButton(
            title: 'Go to Project Dashboard →',
            height: 50,
            borderRadius: 12,
            backgroundColor: AppColors.primary,
            onPressed: onDashboardTap,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String sectionTitle) {
    return Text(
      sectionTitle,
      style: TextStyle(
        fontSize: 14.sp,
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
            isUnsignedRejected: party.isUnsignedRejected,
          );
        },
      ),
    );
  }
}
