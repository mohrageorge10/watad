import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/bids/domain/usecases/submit_bid_usecase.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/submit_bid_form_section.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/sections/submit_bid_header_section.dart';

class SubmitBidScreen extends StatefulWidget {
  final String? projectId;
  final String projectName;
  final String initialCost;
  final String initialDuration;
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final OnSubmitBidCallback? onSubmitTap;

  const SubmitBidScreen({
    super.key,
    this.projectId,
    this.projectName = 'Villa Construction Project - New Cairo',
    this.initialCost = '2,000,000',
    this.initialDuration = '6',
    this.onBackTap,
    this.onSettingsTap,
    this.onSubmitTap,
  });

  @override
  State<SubmitBidScreen> createState() => _SubmitBidScreenState();
}

class _SubmitBidScreenState extends State<SubmitBidScreen> {
  bool _isLoading = false;

  Future<void> _handleSubmit({
    required String proposedCost,
    required String proposedDuration,
    required String technicalProposal,
    String? attachmentPath,
  }) async {
    if (widget.onSubmitTap != null) {
      await widget.onSubmitTap!(
        proposedCost: proposedCost,
        proposedDuration: proposedDuration,
        technicalProposal: technicalProposal,
        attachmentPath: attachmentPath,
      );
      return;
    }

    if (widget.projectId != null && widget.projectId!.isNotEmpty) {
      setState(() => _isLoading = true);

      try {
        final submitBidUseCase = sl<SubmitBidUseCase>();
        final result = await submitBidUseCase(
          projectId: widget.projectId!,
          proposedCost: proposedCost,
          proposedDuration: proposedDuration,
          technicalProposal: technicalProposal,
          attachmentFilePath: attachmentPath,
        );

        if (!mounted) return;
        setState(() => _isLoading = false);

        result.fold(
          (isSuccess) {
            AppToast.showSuccess(
              context,
              'Your bid has been submitted successfully!',
            );
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted && context.canPop()) {
                context.pop();
              }
            });
          },
          (failure) {
            AppToast.showError(context, failure.errMessage);
          },
        );
      } catch (e) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        AppToast.showError(context, 'Failed to submit bid: $e');
      }
    } else {
      AppToast.showSuccess(
        context,
        'Your bid has been submitted successfully!',
      );
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && context.canPop()) {
          context.pop();
        }
      });
    }
  }

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
              onBackTap: widget.onBackTap,
              onSettingsTap: widget.onSettingsTap,
            ),

            // Form Section
            SubmitBidFormSection(
              projectName: widget.projectName,
              initialCost: widget.initialCost,
              initialDuration: widget.initialDuration,
              isLoading: _isLoading,
              onSubmit: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}
