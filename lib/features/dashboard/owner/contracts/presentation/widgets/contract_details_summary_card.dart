import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_card.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/contracts/data/models/contract_details_dto.dart';

class ContractDetailsSummaryCard extends StatelessWidget {
  final ContractDetailsDto contract;

  const ContractDetailsSummaryCard({
    super.key,
    required this.contract,
  });

  @override
  Widget build(BuildContext context) {
    final contractNo = contract.id.length >= 8
        ? contract.id.substring(0, 8).toUpperCase()
        : contract.id.toUpperCase();

    return AppCard(
      padding: EdgeInsets.all(16.r),
      borderRadius: 16.r,
      border: Border.all(color: AppColors.grey200),
      boxShadow: [
        BoxShadow(
          color: AppColors.grey300.withValues(alpha: 0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      child: Column(
        children: [
          _DetailRow(
            icon: Icons.description_outlined,
            title: 'Contract No.',
            value: 'CTR-$contractNo',
          ),
          const _DetailDivider(),
          _DetailRow(
            icon: Icons.description_outlined,
            title: 'Contract Terms',
            value: contract.termsAndConditions?.isNotEmpty == true
                ? 'Custom Terms'
                : 'Standard Terms',
          ),
          const _DetailDivider(),
          _DetailRow(
            icon: Icons.dashboard_customize_outlined,
            title: 'Payment Milestones',
            value: '${contract.milestones.length} Milestones Defined',
          ),
          const _DetailDivider(),
          _DetailRow(
            icon: Icons.calendar_today_outlined,
            title: 'Start Date',
            value: contract.startDate,
          ),
          const _DetailDivider(),
          _DetailRow(
            icon: Icons.calendar_today_outlined,
            title: 'End Date',
            value: contract.endDate,
          ),
          const _DetailDivider(),
          _DetailRow(
            icon: Icons.monetization_on_outlined,
            title: 'Total Contract Value (EGP)',
            value: '${contract.totalValue} EGP',
            isBoldValue: true,
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool isBoldValue;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
    this.isBoldValue = false,
  });

  @override
  Widget build(BuildContext context) {
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
}

class _DetailDivider extends StatelessWidget {
  const _DetailDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: const Divider(color: AppColors.grey200, thickness: 1),
    );
  }
}
