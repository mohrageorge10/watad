import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/cubit/create_project_cubit.dart';

class Step4Section extends StatefulWidget {
  const Step4Section({super.key});

  @override
  State<Step4Section> createState() => _Step4SectionState();
}

class _Step4SectionState extends State<Step4Section> {
  late final TextEditingController _constructionCostController;
  late final TextEditingController _finishingCostController;
  late final TextEditingController _otherCostsController;

  @override
  void initState() {
    super.initState();
    final s = context.read<CreateProjectCubit>().state;
    _constructionCostController = TextEditingController(
      text: s.estimatedConstructionCost > 0 ? s.estimatedConstructionCost.toInt().toString() : '',
    );
    _finishingCostController = TextEditingController(
      text: s.finishingCost > 0 ? s.finishingCost.toInt().toString() : '',
    );
    _otherCostsController = TextEditingController(
      text: s.otherCosts > 0 ? s.otherCosts.toInt().toString() : '',
    );
  }

  @override
  void dispose() {
    _constructionCostController.dispose();
    _finishingCostController.dispose();
    _otherCostsController.dispose();
    super.dispose();
  }

  void _updateTotal(CreateProjectCubit cubit) {
    final construction = double.tryParse(_constructionCostController.text) ?? 0;
    final finishing = double.tryParse(_finishingCostController.text) ?? 0;
    final other = double.tryParse(_otherCostsController.text) ?? 0;
    final total = construction + finishing + other;
    cubit.updateData(
      estimatedConstructionCost: construction,
      finishingCost: finishing,
      otherCosts: other,
      estimatedBudget: total,
    );
  }

  String _formatCurrency(double value) {
    if (value <= 0) return '0';
    final formatted = value.toInt().toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateProjectCubit>();
    return BlocBuilder<CreateProjectCubit, CreateProjectState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Text('Budget (EGP)', style: AppTextStyles.font18SemiBoldDark),
              SizedBox(height: 16.h),
              _buildBudgetRow(
                'Estimated Construction Cost',
                _constructionCostController,
                (v) => _updateTotal(cubit),
              ),
              _buildDivider(),
              _buildBudgetRow(
                'Finishing Cost',
                _finishingCostController,
                (v) => _updateTotal(cubit),
              ),
              _buildDivider(),
              _buildBudgetRow(
                'Other Costs',
                _otherCostsController,
                (v) => _updateTotal(cubit),
              ),
              _buildDivider(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Estimated Budget',
                        style: AppTextStyles.font14SemiBoldDark.copyWith(
                          color: AppColors.primary,
                        )),
                    Text(
                      _formatCurrency(state.estimatedBudget),
                      style: AppTextStyles.font14SemiBoldDark.copyWith(
                        color: AppColors.primary,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              // Feasibility Proactive Prompt
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.grey200),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.grey300.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Proactive Prompt',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14SemiBoldDark.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Would you like to run a quick feasibility study to estimate your project cost?',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font12RegularGrey,
                    ),
                    SizedBox(height: 16.h),
                    OutlinedButton(
                      onPressed: () => context.push(AppRoutes.feasibilityCalculator),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 44.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        side: const BorderSide(color: AppColors.primary),
                      ),
                      child: Text(
                        'Yes, Run Feasibility Study',
                        style: AppTextStyles.font14Medium.copyWith(color: AppColors.primary),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    OutlinedButton(
                      onPressed: () => cubit.nextStep(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 44.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        side: const BorderSide(color: AppColors.grey300),
                      ),
                      child: Text(
                        'No, Continue',
                        style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey600),
                      ),
                    ),
                  ],
                ),
              ),
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
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text('Back',
                          style: AppTextStyles.font14Medium.copyWith(color: AppColors.primary)),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: AppElevatedButton(
                      title: 'Next',
                      onPressed: () => cubit.nextStep(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBudgetRow(
    String label,
    TextEditingController controller,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey800)),
          ),
          SizedBox(width: 12.w),
          SizedBox(
            width: 120.w,
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.end,
              onChanged: onChanged,
              style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey900),
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: AppTextStyles.font14Regular.copyWith(color: AppColors.grey400),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() => Divider(height: 1.h, color: AppColors.grey200);
}
