import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/cubit/create_project_cubit.dart';

class Step5Section extends StatelessWidget {
  const Step5Section({super.key});

  String _finishingLevelName(int level) {
    switch (level) {
      case 0: return 'Basic';
      case 1: return 'Standard';
      case 2: return 'High';
      default: return 'Standard';
    }
  }

  String _formatCurrency(double value) {
    if (value <= 0) return '0 EGP';
    final formatted = value.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return '$formatted EGP';
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateProjectCubit, CreateProjectState>(
      listener: (context, state) {
        if (state.status == CreateProjectStatus.success) {
          AppToast.showSuccess(context, 'Project created successfully!');
          Navigator.of(context).pop();
        } else if (state.status == CreateProjectStatus.error) {
          AppToast.showError(
            context,
            state.failure?.errMessage ?? 'Something went wrong',
          );
        }
      },
      child: BlocBuilder<CreateProjectCubit, CreateProjectState>(
        builder: (context, state) {
          final cubit = context.read<CreateProjectCubit>();
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.white100,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project preview card (no border, just layout)
                  Row(
                    children: [
                      Container(
                        width: 72.w,
                        height: 72.w,
                        decoration: BoxDecoration(
                          color: AppColors.grey200,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.home_work_outlined,
                          color: AppColors.grey500,
                          size: 32.r,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    state.title.isNotEmpty ? state.title : 'Untitled Project',
                                    style: AppTextStyles.font14SemiBoldDark,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary, // Green in screenshot, but we use primary or green if exists. Let's use a green color
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text('Draft',
                                      style: AppTextStyles.font12Regular.copyWith(
                                          color: AppColors.white100)),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${state.city}, ${state.governorate}',
                              style: AppTextStyles.font12RegularGrey,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '${state.landArea.toInt()} m²  •  ${state.floorsCount} Floors\n${_finishingLevelName(state.finishingLevel)} Finishing',
                              style: AppTextStyles.font12RegularGrey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // Summary rows
                  _buildSummaryRow('Land Area (m²)', '${state.landArea.toInt()}'),
                  _buildSummaryRow('Number of Floors', '${state.floorsCount}'),
                  _buildSummaryRow('Location', '${state.city}, ${state.governorate}'),
                  _buildSummaryRow('Finishing Level', _finishingLevelName(state.finishingLevel)),
                  _buildSummaryRow('Estimated Budget', _formatCurrency(state.estimatedBudget)),
                  _buildSummaryRow(
                    'Expected Start Date',
                    '${state.expectedStartDate.day} ${_monthName(state.expectedStartDate.month)} ${state.expectedStartDate.year}',
                  ),
                  _buildSummaryRow(
                    'Expected Duration',
                    '${state.expectedDurationMonths} Months',
                  ),
                  SizedBox(height: 32.h),
                  // Edit button
                  OutlinedButton(
                    onPressed: () => cubit.goToStep(1),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 48.h),
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: Text(
                      'Edit Details',
                      style: AppTextStyles.font14Medium.copyWith(color: AppColors.primary),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Create button
                  AppElevatedButton(
                    title: state.status == CreateProjectStatus.loading
                        ? 'Creating...'
                        : 'Create Project',
                    borderRadius: 24,
                    onPressed: state.status == CreateProjectStatus.loading
                        ? null
                        : () => cubit.submitProject(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Builder(builder: (context) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label,
                    style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey600)),
                Text(value,
                    style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey900)),
              ],
            ),
          ),
          Divider(height: 1.h, color: AppColors.grey100),
        ],
      );
    });
  }
}
