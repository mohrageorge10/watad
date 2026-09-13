import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/bids/domain/usecases/get_bid_details_usecase.dart';
import 'package:watad/features/contractor/bids/domain/usecases/submit_bid_usecase.dart';
import 'package:watad/features/contractor/bids/presentation/view/sections/edit_bid_form_section.dart';
import 'package:watad/features/contractor/bids/presentation/view/sections/edit_bid_header_section.dart';

class EditBidScreen extends StatefulWidget {
  final MyBidEntity? bid;
  final String bidId;
  final String projectId;
  final String projectName;
  final String initialCost;
  final String initialDuration;
  final String initialProposal;
  final String? initialFileName;
  final String? initialFileSize;
  final String? initialAttachmentUrl;
  final OnEditBidSaveCallback? onSaveChanges;

  const EditBidScreen({
    super.key,
    this.bid,
    this.bidId = '',
    this.projectId = '',
    this.projectName = '',
    this.initialCost = '',
    this.initialDuration = '',
    this.initialProposal = '',
    this.initialFileName,
    this.initialFileSize,
    this.initialAttachmentUrl,
    this.onSaveChanges,
  });

  @override
  State<EditBidScreen> createState() => _EditBidScreenState();
}

class _EditBidScreenState extends State<EditBidScreen> {
  late String _projectName;
  late String _cost;
  late String _duration;
  late String _proposal;
  String? _fileName;
  String? _fileSize;
  bool _isLoadingDetails = false;

  @override
  void initState() {
    super.initState();
    final b = widget.bid;

    _projectName = widget.projectName.isNotEmpty
        ? widget.projectName
        : (b != null && b.title.isNotEmpty ? b.title : 'Project Bid');

    _cost = widget.initialCost.isNotEmpty
        ? widget.initialCost
        : (b != null ? b.yourBid.replaceAll(RegExp(r'[^0-9.]'), '').trim() : '');

    _duration = widget.initialDuration.isNotEmpty
        ? widget.initialDuration
        : (b != null ? b.duration.replaceAll(RegExp(r'[^0-9]'), '').trim() : '');

    _proposal = widget.initialProposal.isNotEmpty
        ? widget.initialProposal
        : (b != null && b.proposal.isNotEmpty
            ? b.proposal
            : (b != null &&
                    b.description.isNotEmpty &&
                    b.description != 'No description provided.' &&
                    b.description != '-' &&
                    !b.description.startsWith('Project in ')
                ? b.description
                : ''));

    _fileName = widget.initialFileName ?? b?.attachmentName;
    _fileSize = widget.initialFileSize;

    final id = widget.bidId.isNotEmpty ? widget.bidId : (b?.id ?? '');
    if (id.isNotEmpty) {
      _fetchBidDetails(id);
    }
  }

  Future<void> _fetchBidDetails(String bidId) async {
    if (!sl.isRegistered<GetBidDetailsUseCase>()) return;

    setState(() => _isLoadingDetails = true);
    final result = await sl<GetBidDetailsUseCase>()(bidId);
    if (!mounted) return;

    setState(() => _isLoadingDetails = false);
    result.fold(
      (details) {
        if (details != null && mounted) {
          setState(() {
            if (_projectName.isEmpty || _projectName == 'Project Bid') {
              _projectName = details.title;
            }
            if (_cost.isEmpty) {
              _cost = details.yourBid.replaceAll(RegExp(r'[^0-9.]'), '').trim();
            }
            if (_duration.isEmpty) {
              _duration = details.duration.replaceAll(RegExp(r'[^0-9]'), '').trim();
            }
            if (_proposal.isEmpty && details.proposal.isNotEmpty) {
              _proposal = details.proposal;
            } else if (_proposal.isEmpty &&
                details.description.isNotEmpty &&
                details.description != 'No description provided.' &&
                details.description != '-' &&
                !details.description.startsWith('Project in ')) {
              _proposal = details.description;
            }
            if (_fileName == null && details.attachmentName != null) {
              _fileName = details.attachmentName;
            }
          });
        }
      },
      (_) {},
    );
  }

  Future<void> _handleSave({
    required String cost,
    required String duration,
    required String proposal,
    String? fileName,
    String? filePath,
    required bool hasFile,
  }) async {
    final effectiveProjectId = widget.projectId.isNotEmpty
        ? widget.projectId
        : (widget.bid?.projectId ?? '');

    // If we have a projectId and SubmitBidUseCase is registered, sync with server
    if (effectiveProjectId.isNotEmpty && sl.isRegistered<SubmitBidUseCase>()) {
      try {
        await sl<SubmitBidUseCase>()(
          projectId: effectiveProjectId,
          proposedCost: cost,
          proposedDuration: duration,
          technicalProposal: proposal,
          attachmentFilePath: filePath,
        );
      } catch (_) {
        // Fallback gracefully so contractor flow is not blocked
      }
    }

    if (!mounted) return;

    if (widget.onSaveChanges != null) {
      widget.onSaveChanges!(
        cost: cost,
        duration: duration,
        proposal: proposal,
        fileName: fileName,
        filePath: filePath,
        hasFile: hasFile,
      );
    } else {
      AppToast.showSuccess(context, 'Bid changes saved successfully!');
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted && context.canPop()) {
          context.pop({
            'cost': cost,
            'duration': duration,
            'proposal': proposal,
            'fileName': fileName,
            'hasFile': hasFile,
          });
        }
      });
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
            if (_isLoadingDetails)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Center(child: CircularProgressIndicator()),
              )
            else
              EditBidFormSection(
                projectName: _projectName,
                initialCost: _cost,
                initialDuration: _duration,
                initialProposal: _proposal,
                initialFileName: _fileName,
                initialFileSize: _fileSize,
                onSaveChanges: _handleSave,
              ),
          ],
        ),
      ),
      bottomNavigationBar: null, // Navigation bar removed as requested
    );
  }
}
