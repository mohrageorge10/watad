import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/submit_bid_project_context_card.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/submit_bid_upload_zone.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/submit_bid_uploaded_file_tile.dart';
import 'package:watad/core/shared/widgets/permission_confirmation_dialog.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/shadowed_text_field.dart';

class SubmitBidFormSection extends StatefulWidget {
  final String projectName;
  final String initialCost;
  final String initialDuration;
  final VoidCallback? onSubmitTap;

  const SubmitBidFormSection({
    super.key,
    required this.projectName,
    this.initialCost = '2,450,000',
    this.initialDuration = '6',
    this.onSubmitTap,
  });

  @override
  State<SubmitBidFormSection> createState() => _SubmitBidFormSectionState();
}

class _SubmitBidFormSectionState extends State<SubmitBidFormSection> {
  late final TextEditingController _costController;
  late final TextEditingController _durationController;
  late final TextEditingController _proposalController;

  bool _hasFile = true;
  String _fileName = 'Technical_Proposal.pdf';
  String _fileSize = '4.2 MB';

  final String _defaultProposal =
      'We will deliver the project with high quality and on time, using experienced team and modern construction techniques.';

  @override
  void initState() {
    super.initState();
    _costController = TextEditingController(text: widget.initialCost);
    _durationController = TextEditingController(text: widget.initialDuration);
    _proposalController = TextEditingController(text: _defaultProposal);
  }

  @override
  void dispose() {
    _costController.dispose();
    _durationController.dispose();
    _proposalController.dispose();
    super.dispose();
  }

  Future<void> _handleFilePick(BuildContext context) async {
    const permissionKey = CacheKeys.storagePermissionGranted;

    CacheHelper? cache;
    try {
      if (sl.isRegistered<CacheHelper>()) {
        cache = sl<CacheHelper>();
      }
    } catch (_) {}

    final bool isAlreadyGranted =
        cache != null && cache.getData(key: permissionKey) == true;

    // 1. Request confirmation if not granted yet
    if (!isAlreadyGranted) {
      final bool granted = await PermissionConfirmationDialog.show(
        context,
        title: 'Device Files & Storage Access',
        message:
            'Watad needs permission to access your device storage to attach documents (PDF, DOC, DOCX) to your bid proposal.',
        icon: Icons.upload_file_rounded,
      );

      if (!granted) {
        if (context.mounted) {
          AppToast.showError(
            context,
            'File access permission is required to attach files.',
          );
        }
        return;
      }

      if (cache != null) {
        await cache.saveData(key: permissionKey, value: true);
      }
    }

    // 2. Open real native file picker
    try {
      List<PlatformFile> files = [];
      try {
        files = await FilePicker.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx'],
        );
      } catch (_) {
        files = await FilePicker.pickFiles();
      }

      if (files.isNotEmpty) {
        final picked = files.first;
        final fileSize = picked.lengthSync() ?? await picked.length();

        // Verify Max 20MB limit
        if (fileSize > 20 * 1024 * 1024) {
          if (context.mounted) {
            AppToast.showError(
              context,
              'File size exceeds 20MB limit. Please choose a smaller file.',
            );
          }
          return;
        }

        final sizeInMb = fileSize / (1024 * 1024);
        final formattedSize = sizeInMb >= 0.1
            ? '${sizeInMb.toStringAsFixed(1)} MB'
            : '${(fileSize / 1024).toStringAsFixed(0)} KB';

        setState(() {
          _hasFile = true;
          _fileName = picked.name;
          _fileSize = formattedSize;
        });

        if (context.mounted) {
          AppToast.showSuccess(
            context,
            'File attached: ${picked.name}',
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        AppToast.showError(
          context,
          'Could not pick file: $e',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Project Context Card
          SubmitBidProjectContextCard(
            projectName: widget.projectName,
          ),

          SizedBox(height: 24.h),

          // 2. Proposed Cost
          ShadowedTextField(
            label: 'Proposed Cost (EGP) *',
            controller: _costController,
            inputType: ShadowedInputType.number,
            suffixText: 'EGP',
            valueColor: AppColors.primary,
          ),

          SizedBox(height: 20.h),

          // 3. Proposed Duration
          ShadowedTextField(
            label: 'Proposed Duration (Months) *',
            controller: _durationController,
            inputType: ShadowedInputType.number,
            suffixText: 'Months',
            valueColor: AppColors.primary,
          ),

          SizedBox(height: 20.h),

          // 4. Technical Proposal
          ShadowedTextField(
            label: 'Technical Proposal *',
            controller: _proposalController,
            inputType: ShadowedInputType.multiline,
            maxLines: 4,
            onChanged: (val) {
              setState(() {});
            },
          ),

          SizedBox(height: 6.h),

          // Character counter aligned right
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${_proposalController.text.length}/500',
              style: TextStyle(
                color: const Color(0xFF8E8E93),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          SizedBox(height: 20.h),

          // 5. Attachments Section
          Text(
            'Attachments (Optional)',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 12.h),

          // Upload Drop Zone
          SubmitBidUploadZone(
            onTap: () => _handleFilePick(context),
          ),

          // Uploaded File Tile (if present)
          if (_hasFile) ...[
            SizedBox(height: 12.h),
            SubmitBidUploadedFileTile(
              fileName: _fileName,
              fileSize: _fileSize,
              onRemove: () {
                setState(() {
                  _hasFile = false;
                });
                AppToast.showSuccess(context, 'File removed');
              },
            ),
          ],

          SizedBox(height: 32.h),

          // 6. Submit Button
          AppElevatedButton(
            title: 'Confirm & Send Bid',
            onPressed: widget.onSubmitTap ?? () {},
            backgroundColor: AppColors.primary,
            borderRadius: 12.r,
            height: 50.h,
            textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white100,
            ),
          ),
        ],
      ),
    );
  }
}
