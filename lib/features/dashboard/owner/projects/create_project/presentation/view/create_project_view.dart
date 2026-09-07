import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/cubit/create_project_cubit.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/widgets/step1_section.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/widgets/step2_section.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/widgets/step3_section.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/widgets/step5_section.dart';

class CreateProjectView extends StatelessWidget {
  const CreateProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CreateProjectCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.secondBackground,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildProgressIndicator(),
              Expanded(
                child: BlocBuilder<CreateProjectCubit, CreateProjectState>(
                  builder: (context, state) {
                    final cubit = context.read<CreateProjectCubit>();
                    return PageView(
                      controller: cubit.pageController,
                      physics: const NeverScrollableScrollPhysics(), // Disable swipe
                      children: const [
                        Step1Section(),
                        Step2Section(),
                        Step3Section(),
                        Step5Section(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Builder(builder: (context) {
      return Padding(
        padding: EdgeInsets.only(top: 16.h, left: 24.w, right: 24.w, bottom: 24.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey300.withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  final cubit = context.read<CreateProjectCubit>();
                  if (cubit.state.currentStep > 1) {
                    cubit.previousStep();
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: const Icon(Icons.arrow_back, color: AppColors.primary),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Create New Project",
                    style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary),
                  ),
                ),
              ),
              SizedBox(width: 24.w), // Balance for center alignment
            ],
          ),
        ),
      );
    });
  }

  Widget _buildProgressIndicator() {
    return Builder(
      builder: (context) {
        return BlocBuilder<CreateProjectCubit, CreateProjectState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  final step = index + 1;
                  final isActive = state.currentStep == step;
                  return Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isActive
                              ? AppColors.primary
                              : AppColors.grey200,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          step.toString(),
                          style: AppTextStyles.font14Medium.copyWith(
                            color: isActive
                                ? AppColors.white100
                                : AppColors.grey800,
                          ),
                        ),
                      ),
                      if (step < 4)
                        Container(
                          width: 24.w,
                          height: 2.h,
                          color: AppColors.grey300,
                        ),
                    ],
                  );
                }),
              ),
            );
          },
        );
      },
    );
  }
}
