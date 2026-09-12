import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/submit_bid_form_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/submit_bid_header_section.dart';

class SubmitBidScreen extends StatelessWidget {
  final String projectName;
  final String initialCost;
  final String initialDuration;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onSubmitTap;

  const SubmitBidScreen({
    super.key,
    this.projectName = 'Villa Construction Project - New Cairo',
    this.initialCost = '2,450,000',
    this.initialDuration = '6',
    this.onBackTap,
    this.onSettingsTap,
    this.onSubmitTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      bottomNavigationBar: null, // As requested: without Bottom Navigation Bar
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            SubmitBidHeaderSection(
              title: 'Submit Your Bid',
              onBackTap: onBackTap,
              onSettingsTap: onSettingsTap,
            ),

            // Form Section
            SubmitBidFormSection(
              projectName: projectName,
              initialCost: initialCost,
              initialDuration: initialDuration,
              onSubmitTap: onSubmitTap ??
                  () {
                    AppToast.showSuccess(
                      context,
                      'Your bid has been submitted successfully!',
                    );
                    Future.delayed(const Duration(milliseconds: 500), () {
                      if (context.mounted && context.canPop()) {
                        context.pop();
                      }
                    });
                  },
            ),
          ],
        ),
      ),
    );
  }
}
