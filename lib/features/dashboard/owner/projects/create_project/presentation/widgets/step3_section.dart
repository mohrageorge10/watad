import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/cubit/create_project_cubit.dart';

class Step3Section extends StatefulWidget {
  const Step3Section({super.key});

  @override
  State<Step3Section> createState() => _Step3SectionState();
}

class _Step3SectionState extends State<Step3Section> {
  late int _selectedFinishingLevel;
  late final TextEditingController _estimatedBudgetController;
  late DateTime _startDate;
  late int _durationMonths;

  final List<String> _finishingLabels = ['Basic', 'Standard', 'High'];
  final List<int> _durationOptions = [6, 9, 12, 18, 24, 36];

  @override
  void initState() {
    super.initState();
    final state = context.read<CreateProjectCubit>().state;
    _selectedFinishingLevel = state.finishingLevel;
    _estimatedBudgetController = TextEditingController(
      text: state.estimatedBudget > 0 ? state.estimatedBudget.toInt().toString() : '',
    );
    _startDate = state.expectedStartDate;
    _durationMonths = state.expectedDurationMonths;
  }

  @override
  void dispose() {
    _estimatedBudgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProjectCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Text("Finishing Level", style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.grey900)),
          SizedBox(height: 12.h),
          _buildSegmentedSelector(cubit),
          SizedBox(height: 20.h),
          Text("Estimated Budget (EGP)", style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.grey900)),
          SizedBox(height: 8.h),
          _buildField(
            controller: _estimatedBudgetController,
            hint: '2,000,000',
            keyboardType: TextInputType.number,
            onChanged: (v) => cubit.updateData(estimatedBudget: double.tryParse(v) ?? 0),
          ),
          SizedBox(height: 20.h),
          Text("Expected Start Date", style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.grey900)),
          SizedBox(height: 8.h),
          _buildDatePicker(context, cubit),
          SizedBox(height: 20.h),
          Text("Expected Duration", style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.grey900)),
          SizedBox(height: 8.h),
          _buildDurationDropdown(cubit),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => cubit.previousStep(),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  child: Text('Back',
                      style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child
                
                
                
                : AppElevatedButton(
                  title: 'Next',
                  borderRadius: 30,
                  onPressed: () => cubit.nextStep(),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildSegmentedSelector(CreateProjectCubit cubit) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_finishingLabels.length, (i) {
          final isSelected = _selectedFinishingLevel == i;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedFinishingLevel = i);
                cubit.updateData(finishingLevel: i);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  _finishingLabels[i],
                  style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.grey900).copyWith(
                    color: isSelected ? AppColors.white100 : AppColors.grey600,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context, CreateProjectCubit cubit) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _startDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
        );
        if (picked != null) {
          setState(() => _startDate = picked);
          cubit.updateData(expectedStartDate: picked);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${_startDate.day} ${_monthName(_startDate.month)} ${_startDate.year}',
                style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey900),
              ),
            ),
            const Icon(Icons.calendar_today_outlined, color: AppColors.grey500, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationDropdown(CreateProjectCubit cubit) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
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
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _durationMonths,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.grey600),
          style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey900),
          items: _durationOptions
              .map((m) => DropdownMenuItem(
                    value: m,
                    child: Text('$m Months'),
                  ))
              .toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() => _durationMonths = val);
              cubit.updateData(expectedDurationMonths: val);
            }
          },
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
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
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey900),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.font14Regular.copyWith(color: AppColors.grey400),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}
