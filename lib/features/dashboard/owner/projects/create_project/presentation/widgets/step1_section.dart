import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/cubit/create_project_cubit.dart';

class Step1Section extends StatefulWidget {
  const Step1Section({super.key});

  @override
  State<Step1Section> createState() => _Step1SectionState();
}

class _Step1SectionState extends State<Step1Section> {
  late final TextEditingController _titleController;
  late final TextEditingController _areaController;

  @override
  void initState() {
    super.initState();
    final state = context.read<CreateProjectCubit>().state;
    _titleController = TextEditingController(text: state.title);
    _areaController = TextEditingController(
      text: state.landArea > 0 ? state.landArea.toInt().toString() : '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProjectCubit, CreateProjectState>(
      builder: (context, state) {
        final cubit = context.read<CreateProjectCubit>();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      Text("Project Title", style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.grey900)),
                      SizedBox(height: 8.h),
                      _buildField(
                        controller: _titleController,
                        hint: 'My New Villa',
                        onChanged: (v) => cubit.updateData(title: v),
                      ),
                      SizedBox(height: 20.h),
                      Text("Land Area (m²)", style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.grey900)),
                      SizedBox(height: 8.h),
                      _buildField(
                        controller: _areaController,
                        hint: '500',
                        keyboardType: TextInputType.number,
                        onChanged: (v) => cubit.updateData(landArea: double.tryParse(v) ?? 0),
                      ),
                      SizedBox(height: 20.h),
                      Text("Number of Floors", style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.bold, color: AppColors.grey900)),
                      SizedBox(height: 12.h),
                      _buildFloorSelector(context, state.floorsCount, cubit),
                    ],
                  ),
                ),
              ),
              AppElevatedButton(
                title: "Next",
                borderRadius: 12,
                onPressed: () => cubit.nextStep(),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
      },
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

  Widget _buildFloorSelector(
    BuildContext context,
    int currentValue,
    CreateProjectCubit cubit,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              if (currentValue > 1) {
                cubit.updateData(floorsCount: currentValue - 1);
              }
            },
            icon: Text(
              '−',
              style: AppTextStyles.font20SemiBold.copyWith(color: AppColors.grey800),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              currentValue.toString(),
              style: AppTextStyles.font16BoldWhite,
            ),
          ),
          IconButton(
            onPressed: () => cubit.updateData(floorsCount: currentValue + 1),
            icon: Text(
              '+',
              style: AppTextStyles.font20SemiBold.copyWith(color: AppColors.grey800),
            ),
          ),
        ],
      ),
    );
  }
}
