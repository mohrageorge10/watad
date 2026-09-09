import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/bids/presentation/view/sections/edit_bid_form_section.dart';
import 'package:watad/features/contractor/bids/presentation/view/sections/edit_bid_header_section.dart';
import 'package:watad/features/contractor/home/presentation/view/widgets/contractor_bottom_nav_bar.dart';

class EditBidScreen extends StatelessWidget {
  final String bidId;
  final String projectName;
  final String initialCost;
  final String initialDuration;
  final String initialProposal;
  final String? initialFileName;
  final String? initialFileSize;
  final bool showBottomNavBar;
  final void Function(String cost, String duration)? onSaveChanges;

  const EditBidScreen({
    super.key,
    this.bidId = '',
    this.projectName = 'Villa Construction Project - New Cairo',
    this.initialCost = '2,450,000',
    this.initialDuration = '6',
    this.initialProposal =
        'We will deliver the project with high quality and on time, using experienced team and modern construction techniques.',
    this.initialFileName = 'Technical_Proposal.pdf',
    this.initialFileSize = '4.2 MB',
    this.showBottomNavBar = true,
    this.onSaveChanges,
  });

  void _onBottomNavTapped(BuildContext context, int index) {
    if (index == 3) return; // Already on My Bids

    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.push(AppRoutes.marketplace);
        break;
      case 2:
        context.push(AppRoutes.portfolioProjects);
        break;
      case 4:
        context.push(AppRoutes.contractorProfile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Header Section
            const EditBidHeaderSection(),

            // 2. Form Section
            EditBidFormSection(
              projectName: projectName,
              initialCost: initialCost,
              initialDuration: initialDuration,
              initialProposal: initialProposal,
              initialFileName: initialFileName,
              initialFileSize: initialFileSize,
              onSaveChanges: onSaveChanges ??
                  (cost, duration) {
                    AppToast.showSuccess(
                      context,
                      'Bid changes saved successfully!',
                    );
                    Future.delayed(const Duration(milliseconds: 300), () {
                      if (context.mounted && context.canPop()) {
                        context.pop({
                          'cost': cost,
                          'duration': duration,
                        });
                      }
                    });
                  },
            ),
          ],
        ),
      ),
      bottomNavigationBar: showBottomNavBar
          ? SafeArea(
              top: false,
              child: ContractorBottomNavBar(
                currentIndex: 3, // My Bids is active
                onTap: (index) => _onBottomNavTapped(context, index),
              ),
            )
          : null,
    );
  }
}
