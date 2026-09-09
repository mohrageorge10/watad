import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/marketplace/data/mock/mock_marketplace_details_data.dart';
import 'package:watad/features/contractor/marketplace/domain/entities/marketplace_project_details_entity.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_details_card_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/marketplace_details_header_section.dart';

class MarketplaceProjectDetailsScreen extends StatelessWidget {
  final MarketplaceProjectDetailsEntity? project;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onSubmitBidTap;

  const MarketplaceProjectDetailsScreen({
    super.key,
    this.project,
    this.onBackTap,
    this.onSettingsTap,
    this.onSubmitBidTap,
  });

  @override
  Widget build(BuildContext context) {
    final details = project ?? MockMarketplaceDetailsData.getVillaProjectDetails();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Primary Colored Header Section
            MarketplaceDetailsHeaderSection(
              title: 'Marketplace Project Details',
              onBackTap: onBackTap,
              onSettingsTap: onSettingsTap,
            ),

            // 2. Overlapping Details Card
            Transform.translate(
              offset: Offset(0, -60.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: MarketplaceDetailsCardSection(
                  project: details,
                  onSubmitBidTap: onSubmitBidTap ??
                      () {
                        context.push(AppRoutes.submitBid, extra: details);
                      },
                  onAttachmentTap: (attachment) {
                    AppToast.showSuccess(
                      context,
                      'Downloading ${attachment.title}...',
                    );
                  },
                ),
              ),
            ),

            // Spacing to compensate for negative translation
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
