import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_bid_entity.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_empty_card_widget.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/project_card_widget.dart';

class RecentBidsSection extends StatelessWidget {
  const RecentBidsSection({
    super.key,
    required this.bids,
    this.onViewAllTap,
    this.onBidTap,
    this.onBrowseTendersTap,
  });

  final List<ContractorBidEntity> bids;
  final VoidCallback? onViewAllTap;
  final ValueChanged<ContractorBidEntity>? onBidTap;
  final VoidCallback? onBrowseTendersTap;

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = bids.isEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Bids',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1D1D1F),
                ),
              ),
              InkWell(
                onTap: onViewAllTap,
                borderRadius: BorderRadius.circular(8.r),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (isEmpty)
            ContractorEmptyCardWidget(
              title: 'No Bids Submitted',
              message:
                  'Browse open market place tenders to submit your first poject quotation',
              buttonTitle: 'Browse Tenders',
              onButtonPressed: onBrowseTendersTap,
            )
          else
            ...bids.map(
              (bid) => ProjectCardWidget(
                title: bid.title,
                location: bid.location,
                timeOrAmount: bid.amount,
                badgeText: bid.badgeText,
                badgeColorHex: bid.badgeColorHex,
                progress: null,
                imagePath: bid.image,
                onTap: onBidTap != null ? () => onBidTap!(bid) : null,
              ),
            ),
        ],
      ),
    );
  }
}
