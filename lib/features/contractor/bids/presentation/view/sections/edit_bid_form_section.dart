import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_confirmation_dialog.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/marketplace/presentation/view/widgets/submit_bid_uploaded_file_tile.dart';
import 'package:watad/features/contractor/profile/presentation/view/widgets/shadowed_text_field.dart';

class EditBidFormSection extends StatefulWidget {
  final String projectName;
  final String initialCost;
  final String initialDuration;
  final String initialProposal;
  final String? initialFileName;
  final String? initialFileSize;
  final void Function(String cost, String duration)? onSaveChanges;

  const EditBidFormSection({
    super.key,
    required this.projectName,
    this.initialCost = '2,450,000',
    this.initialDuration = '6',
    this.initialProposal =
        'We will deliver the project with high quality and on time, using experienced team and modern construction techniques.',
    this.initialFileName = 'Technical_Proposal.pdf',
    this.initialFileSize = '4.2 MB',
    this.onSaveChanges,
  });

  @override
  State<EditBidFormSection> createState() => _EditBidFormSectionState();
}

class _EditBidFormSectionState extends State<EditBidFormSection> {
  late final TextEditingController _costController;
  late final TextEditingController _durationController;
  late final TextEditingController _proposalController;

  bool _hasFile = true;
  String _fileName = 'Technical_Proposal.pdf';
  String _fileSize = '4.2 MB';
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _costController = TextEditingController(text: widget.initialCost);
    _durationController = TextEditingController(text: widget.initialDuration);
    _proposalController = TextEditingController(text: widget.initialProposal);
    _fileName = widget.initialFileName ?? 'Technical_Proposal.pdf';
    _fileSize = widget.initialFileSize ?? '4.2 MB';
    _hasFile = widget.initialFileName != null;
    _charCount = _proposalController.text.length;

    _proposalController.addListener(() {
      setState(() {
        _charCount = _proposalController.text.length;
      });
    });
  }

  @override
  void dispose() {
    _costController.dispose();
    _durationController.dispose();
    _proposalController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    const permissionKey = CacheKeys.storagePermissionGranted;
    final cache = sl.isRegistered<CacheHelper>() ? sl<CacheHelper>() : null;
    final bool alreadyGranted =
        cache?.getData(key: permissionKey) as bool? ?? false;

    if (!alreadyGranted) {
      final granted = await AppConfirmationDialog.show(
        context,
        title: 'Storage Access Permission',
        message:
            'Watad needs permission to access your device storage to attach documents (PDF, DOC, DOCX) to your bid proposal.',
        icon: Icons.upload_file_rounded,
        confirmText: 'Allow',
      );

      if (!granted) {
        if (mounted) {
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

    try {
      List<PlatformFile> files = [];
      try {
        files = await FilePicker.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx'],
        );
      } catch (_) {
        // Fallback to any file type if custom extensions are not handled by OS intent
        files = await FilePicker.pickFiles();
      }

      if (files.isNotEmpty) {
        final picked = files.first;
        final fileSize = picked.lengthSync() ?? await picked.length();

        // Max 20MB limit
        if (fileSize > 20 * 1024 * 1024) {
          if (mounted) {
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

        if (mounted) {
          AppToast.showSuccess(
            context,
            'File "$_fileName" attached successfully.',
          );
        }
      }
    } catch (e) {
      if (mounted) {
        AppToast.showError(
          context,
          'Failed to open file picker: ${e.toString()}',
        );
      }
    }
  }

  void _handleSave() {
    final cost = _costController.text.trim();
    final duration = _durationController.text.trim();

    if (cost.isEmpty) {
      AppToast.showError(context, 'Please enter proposed cost.');
      return;
    }
    if (duration.isEmpty) {
      AppToast.showError(context, 'Please enter proposed duration.');
      return;
    }

    if (widget.onSaveChanges != null) {
      widget.onSaveChanges!(cost, duration);
    } else {
      AppToast.showSuccess(context, 'Changes saved successfully!');
      if (context.canPop()) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Project Context Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFFE5E5EA), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PROJECT CONTEXT',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.projectName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 20.h),

          // 2. Proposed Cost (EGP) *
          ShadowedTextField(
            label: 'Proposed Cost (EGP) *',
            controller: _costController,
            hintText: 'Enter cost',
            inputType: ShadowedInputType.number,
            suffixText: 'EGP',
            suffixColor: AppColors.primary,
            valueColor: const Color(0xFF1D1D1F),
          ),

          SizedBox(height: 16.h),

          // 3. Proposed Duration (Months) *
          ShadowedTextField(
            label: 'Proposed Duration (Months) *',
            controller: _durationController,
            hintText: 'Enter duration',
            inputType: ShadowedInputType.number,
            suffixText: 'Months',
            suffixColor: const Color(0xFF8E8E93),
            valueColor: const Color(0xFF1D1D1F),
          ),

          SizedBox(height: 16.h),

          // 4. Technical Proposal *
          ShadowedTextField(
            label: 'Technical Proposal *',
            controller: _proposalController,
            hintText: 'Provide a brief summary of your proposal...',
            inputType: ShadowedInputType.multiline,
            maxLines: 4,
            valueColor: AppColors.primary,
          ),
          SizedBox(height: 6.h),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$_charCount/500',
              style: TextStyle(
                color: const Color(0xFF8E8E93),
                fontSize: 12.sp,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // 5. Attachments (Optional)
          Text(
            'Attachments (Optional)',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),

          if (_hasFile) ...[
            SubmitBidUploadedFileTile(
              fileName: _fileName,
              fileSize: _fileSize,
              onRemove: () {
                setState(() {
                  _hasFile = false;
                });
              },
            ),
            SizedBox(height: 12.h),
          ],

          // Add Attachment Action Card (Centered Column per schema)
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _pickFile,
              borderRadius: BorderRadius.circular(12.r),
              child: Ink(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: const Color(0xFFE5E5EA),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.attach_file_rounded,
                      color: AppColors.primary,
                      size: 24.r,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      _hasFile ? 'Replace Attachment' : 'Add Attachment',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // 6. Action Buttons: Save Changes & Cancel (Height 50px, borderRadius 12px)
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Save Changes',
                style: TextStyle(
                  color: AppColors.white100,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 12.h),

          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: OutlinedButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.white100,
                side: const BorderSide(
                  color: Color(0xFFE5E5EA),
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
