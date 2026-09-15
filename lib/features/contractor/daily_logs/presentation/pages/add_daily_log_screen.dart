import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/shared/widgets/permission_confirmation_dialog.dart';
import 'package:watad/features/contractor/daily_logs/presentation/cubit/add_daily_log_cubit.dart';
import 'package:watad/features/contractor/daily_logs/presentation/cubit/add_daily_log_state.dart';
import 'package:watad/features/contractor/daily_logs/presentation/view/sections/add_daily_log_ai_scan_card_section.dart';
import 'package:watad/features/contractor/daily_logs/presentation/view/sections/add_daily_log_form_fields_section.dart';
import 'package:watad/features/contractor/daily_logs/presentation/view/sections/add_daily_log_location_timestamp_section.dart';
import 'package:watad/features/contractor/daily_logs/presentation/view/sections/add_daily_log_media_upload_section.dart';
import 'package:watad/features/contractor/daily_logs/presentation/view/sections/add_daily_log_project_header_section.dart';
import 'package:watad/features/contractor/daily_logs/presentation/view/widgets/smart_scan_image_picker_dialog.dart';

class AddDailyLogScreen extends StatelessWidget {
  final String? projectId;
  final String? projectName;
  final String? milestoneName;
  final String? milestoneId;
  final String? location;
  final VoidCallback? onBackTap;

  const AddDailyLogScreen({
    super.key,
    this.projectId,
    this.projectName,
    this.milestoneName,
    this.milestoneId,
    this.location,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddDailyLogCubit>(),
      child: _AddDailyLogView(
        projectId: projectId ?? 'proj_1',
        projectName: projectName ?? 'Project Site',
        milestoneName: milestoneName ?? 'Active Milestone',
        milestoneId: milestoneId ?? '',
        location: location ?? 'Site Location',
        onBackTap: onBackTap,
      ),
    );
  }
}

class _AddDailyLogView extends StatefulWidget {
  final String projectId;
  final String projectName;
  final String milestoneName;
  final String milestoneId;
  final String location;
  final VoidCallback? onBackTap;

  const _AddDailyLogView({
    required this.projectId,
    required this.projectName,
    required this.milestoneName,
    required this.milestoneId,
    required this.location,
    this.onBackTap,
  });

  @override
  State<_AddDailyLogView> createState() => _AddDailyLogViewState();
}

class _AddDailyLogViewState extends State<_AddDailyLogView> {
  late final TextEditingController _workSummaryController;
  late final TextEditingController _equipmentController;
  late final TextEditingController _workersController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _workSummaryController = TextEditingController();
    _equipmentController = TextEditingController();
    _workersController = TextEditingController();
  }

  @override
  void dispose() {
    _workSummaryController.dispose();
    _equipmentController.dispose();
    _workersController.dispose();
    super.dispose();
  }

  Future<void> _handlePickImages() async {
    final hasPermission = await PermissionConfirmationDialog.show(
      context,
      title: 'Gallery Access',
      message: 'Watad would like to access your Photos to upload site daily logs.',
      icon: Icons.photo_library_rounded,
    );
    if (!hasPermission) return;

    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty && mounted) {
        final paths = images.map((img) => img.path).toList();
        context.read<AddDailyLogCubit>().addMedia(paths);
      }
    } catch (_) {
      if (mounted) {
        AppToast.showError(context, 'Unable to open gallery');
      }
    }
  }

  Future<void> _handleSmartScanTap(AddDailyLogState state) async {
    if (state.mediaList.isEmpty) {
      if (mounted) {
        AppToast.showInfo(
          context,
          'Please upload at least one site photo first to run AI scan.',
        );
      }
      return;
    }

    final selectedPath = await SmartScanImagePickerDialog.show(
      context,
      mediaList: state.mediaList,
    );

    if (selectedPath == null || !mounted) return;

    final result = await context.pushNamed<dynamic>(
      AppRoutes.contractorAiCrackInspection,
      extra: {
        'imagePath': selectedPath,
        'location': widget.location,
      },
    );

    if (result != null && result is String && mounted) {
      context.read<AddDailyLogCubit>().setAiScanResult(result);
    }
  }

  void _handleSubmit() {
    final cubit = context.read<AddDailyLogCubit>();
    final summary = _workSummaryController.text.trim();
    final equipment = _equipmentController.text.trim();
    final workers = int.tryParse(_workersController.text.trim()) ?? 0;

    cubit.submitDailyLog(
      projectId: widget.projectId,
      projectName: widget.projectName,
      milestoneName: widget.milestoneName,
      milestoneId: widget.milestoneId,
      location: widget.location,
      workSummary: summary,
      equipmentUsed: equipment,
      workersCount: workers,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddDailyLogCubit, AddDailyLogState>(
      listener: (context, state) {
        if (state.isSubmitSuccess) {
          AppToast.showSuccess(
            context,
            'Daily Log submitted successfully!',
          );
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(AppRoutes.contractorProjectDashboard);
          }
        }

        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          AppToast.showError(context, state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FA),
          appBar: AppBar(
            backgroundColor: const Color(0xFF1E3A8A), // Dark Blue Header
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20.r,
              ),
              onPressed: widget.onBackTap ??
                  () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go(AppRoutes.contractorProjectDashboard);
                    }
                  },
            ),
            title: Text(
              'Add Daily Log',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 36.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Project Header Card
                AddDailyLogProjectHeaderSection(
                  projectName: widget.projectName,
                  milestoneName: widget.milestoneName,
                  status: 'In Progress',
                  siteLocation: widget.location,
                  dateFormatted: 'Today',
                  thumbnailUrl: 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=400&q=80',
                ),

                SizedBox(height: 16.h),

                // 2. Media Upload Section
                AddDailyLogMediaUploadSection(
                  mediaList: state.mediaList,
                  onDropzoneTap: _handlePickImages,
                  onAddMoreTap: _handlePickImages,
                  onDeletePhoto: (index) {
                    context.read<AddDailyLogCubit>().removeMedia(index);
                  },
                ),

                SizedBox(height: 16.h),

                // 3. Scan with AI • Crack Detection Card
                AddDailyLogAiScanCardSection(
                  aiScanStatus: state.aiScanStatus,
                  aiScanResult: state.aiScanResult,
                  onRunScanTap: () => _handleSmartScanTap(state),
                ),

                SizedBox(height: 16.h),

                // 4. Form Fields (Work Summary, Equipment Used, Workers Count)
                AddDailyLogFormFieldsSection(
                  workSummaryController: _workSummaryController,
                  equipmentController: _equipmentController,
                  workersController: _workersController,
                ),

                SizedBox(height: 16.h),

                // 5. Location Tagged & Timestamp Section
                const AddDailyLogLocationTimestampSection(
                  locationCoords: '30.0444° N, 31.2357° E',
                  timestamp: 'Live GPS Verified',
                ),

                SizedBox(height: 24.h),

                // 6. Submit Button
                AppElevatedButton(
                  title: 'Submit Daily Log',
                  height: 52,
                  borderRadius: 14,
                  backgroundColor: const Color(0xFF1E3A8A),
                  isLoading: state.isSubmitting,
                  onPressed: _handleSubmit,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
