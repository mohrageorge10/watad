import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/contracts/data/models/create_contract_request_dto.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';

class MilestonesFormView extends StatefulWidget {
  const MilestonesFormView({super.key});

  @override
  State<MilestonesFormView> createState() => _MilestonesFormViewState();
}

class _MilestonesFormViewState extends State<MilestonesFormView> {
  final _titleController = TextEditingController();
  final _percentageController = TextEditingController();
  final _amountController = TextEditingController();
  String _targetDate = '';

  @override
  void dispose() {
    _titleController.dispose();
    _percentageController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveMilestone() {
    final title = _titleController.text.trim();
    final percentage = num.tryParse(_percentageController.text.trim()) ?? 0;
    final amount = num.tryParse(_amountController.text.replaceAll(',', '').replaceAll('EGP', '').trim()) ?? 0;

    if (title.isEmpty || percentage <= 0 || amount <= 0 || _targetDate.isEmpty) {
      AppToast.showError(context, 'Please fill all fields with valid data');
      return;
    }

    final milestone = CreateMilestoneItemDto(
      title: title,
      costPercentage: percentage,
      amount: amount,
      targetCompletionDate: _targetDate,
    );

    context.pop(milestone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAFD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 90.h,
        title: Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back, color: AppColors.primary700),
                ),
              ),
              Center(
                child: Text(
                  'Add Payment Milestone',
                  style: AppTextStyles.font16SemiBold.copyWith(
                    color: AppColors.primary700,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleField(),
              SizedBox(height: 24.h),
              _buildPercentageField(),
              SizedBox(height: 24.h),
              _buildAmountField(),
              SizedBox(height: 24.h),
              _buildDateField(context),
              SizedBox(height: 40.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: AppColors.white100,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColors.grey200),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: AppTextStyles.btnWhite600.copyWith(
                              color: AppColors.primary700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: _saveMilestone,
                      child: Container(
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary700,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Center(
                          child: Text(
                            'Save Milestone',
                            style: AppTextStyles.btnWhite600.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.layers_outlined, color: AppColors.primary700, size: 20),
            SizedBox(width: 8.w),
            Text(
              'Milestone Title',
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.grey900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'e.g., Foundation & Excavation Phase',
              hintStyle: AppTextStyles.font14Medium.copyWith(color: AppColors.grey400),
            ),
            style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900),
          ),
        ),
      ],
    );
  }

  Widget _buildPercentageField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.percent, color: AppColors.primary700, size: 20),
            SizedBox(width: 8.w),
            Text(
              'Cost Percentage (%)',
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.grey900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _percentageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'e.g., 20',
                    hintStyle: AppTextStyles.font14Medium.copyWith(color: AppColors.grey400),
                  ),
                  style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900),
                ),
              ),
              Text('%', style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey400)),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            const Icon(Icons.data_usage, color: AppColors.grey400, size: 14),
            SizedBox(width: 6.w),
            Text(
              'Percentages across all milestones must sum to 100%.',
              style: AppTextStyles.font12RegularGrey,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAmountField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.monetization_on_outlined, color: AppColors.primary700, size: 20),
            SizedBox(width: 8.w),
            Text(
              'Milestone Amount (EGP)',
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.grey900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          height: 52.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'e.g., 390,000',
                    hintStyle: AppTextStyles.font14Medium.copyWith(color: AppColors.grey400),
                  ),
                  style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900),
                ),
              ),
              Text('EGP', style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey400)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_today_outlined, color: AppColors.primary700, size: 20),
            SizedBox(width: 8.w),
            Text(
              'Target Completion Date',
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.grey900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2050),
            );
            if (date != null) {
              setState(() {
                _targetDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
              });
            }
          },
          child: Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _targetDate.isEmpty ? 'Select target date' : _targetDate,
                    style: AppTextStyles.font14Medium.copyWith(
                      color: _targetDate.isEmpty ? AppColors.grey400 : AppColors.grey900,
                    ),
                  ),
                ),
                const Icon(Icons.calendar_today_outlined, color: AppColors.grey400, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
