import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/contractor/milestone_inspection/presentation/cubit/milestone_inspection_cubit.dart';
import 'package:watad/features/contractor/milestone_inspection/presentation/cubit/milestone_inspection_state.dart';
import 'package:watad/features/contractor/milestone_inspection/presentation/view/sections/milestone_inspection_gallery_section.dart';
import 'package:watad/features/contractor/milestone_inspection/presentation/view/sections/milestone_inspection_header_section.dart';
import 'package:watad/features/contractor/milestone_inspection/presentation/view/sections/milestone_inspection_notes_section.dart';
import 'package:watad/features/contractor/milestone_inspection/presentation/view/sections/milestone_inspection_shimmer_section.dart';

class MilestoneCompletionInspectionScreen extends StatelessWidget {
  final String milestoneId;
  final VoidCallback? onBackTap;

  const MilestoneCompletionInspectionScreen({
    super.key,
    this.milestoneId = 'ms_101',
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MilestoneInspectionCubit>()
        ..loadInspectionDetails(milestoneId),
      child: _MilestoneCompletionInspectionView(
        milestoneId: milestoneId,
        onBackTap: onBackTap,
      ),
    );
  }
}

class _MilestoneCompletionInspectionView extends StatelessWidget {
  final String milestoneId;
  final VoidCallback? onBackTap;

  const _MilestoneCompletionInspectionView({
    required this.milestoneId,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            if (onBackTap != null) {
              onBackTap!();
            } else if (context.canPop()) {
              context.pop();
            }
          },
        ),
        title: Text(
          'Milestone Completion &Inspection Request',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<MilestoneInspectionCubit, MilestoneInspectionState>(
        listener: (context, state) {
          if (state is MilestoneInspectionSuccess) {
            if (state.isSubmitSuccess) {
              AppToast.showSuccess(
                context,
                'Inspection request submitted successfully for review!',
              );
              Navigator.of(context).pop(true);
            } else if (state.submitErrorMessage != null) {
              AppToast.showError(context, state.submitErrorMessage!);
            }
          }
          if (state is MilestoneInspectionError) {
            AppToast.showError(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is MilestoneInspectionLoading ||
              state is MilestoneInspectionInitial) {
            return const MilestoneInspectionShimmerSection();
          }

          if (state is MilestoneInspectionError) {
            return AppEmptyStateWidget(
              title: 'Error Loading Details',
              message: state.message,
              buttonTitle: 'Try Again',
              onButtonPressed: () {
                context
                    .read<MilestoneInspectionCubit>()
                    .loadInspectionDetails(milestoneId);
              },
            );
          }

          if (state is MilestoneInspectionSuccess) {
            final details = state.details;

            return RefreshIndicator(
              color: const Color(0xFF1E3A8A),
              onRefresh: () async {
                await context
                    .read<MilestoneInspectionCubit>()
                    .loadInspectionDetails(milestoneId);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Milestone Header Card
                    MilestoneInspectionHeaderSection(
                      details: details,
                    ),

                    SizedBox(height: 20.h),

                    // 2. Site Logs Gallery Grid Section
                    MilestoneInspectionGallerySection(
                      galleryItems: details.galleryItems,
                    ),

                    SizedBox(height: 20.h),

                    // 3. Notes Section
                    MilestoneInspectionNotesSection(
                      initialNotes: state.notes,
                      onNotesChanged: (val) {
                        context
                            .read<MilestoneInspectionCubit>()
                            .updateNotes(val);
                      },
                    ),

                    SizedBox(height: 24.h),

                    // 4. Request Inspection Action Button
                    AppElevatedButton(
                      title: 'Request Inspection',
                      height: 52,
                      borderRadius: 14,
                      backgroundColor: const Color(0xFF1E3A8A),
                      isLoading: state.isSubmitting,
                      onPressed: () {
                        context
                            .read<MilestoneInspectionCubit>()
                            .submitInspectionRequest(milestoneId);
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
