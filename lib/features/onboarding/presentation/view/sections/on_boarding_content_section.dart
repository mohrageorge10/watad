import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/onboarding/presentation/data/models/on_boarding_model.dart';
import 'package:watad/features/onboarding/presentation/view/widgets/on_boarding_brand_logo_widget.dart';
import 'package:watad/features/onboarding/presentation/view/widgets/on_boarding_dot_indicator_widget.dart';
import 'package:watad/features/onboarding/presentation/view/widgets/on_boarding_skip_button_widget.dart';

class OnBoardingContentSection extends StatelessWidget {
  final OnBoardingModel item;
  final int itemCount;
  final int currentIndex;
  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;
  const OnBoardingContentSection({
    super.key,
    required this.item,
    required this.itemCount,
    required this.currentIndex,
    required this.onNextPressed,
    required this.onSkipPressed,
  });
  @override
  Widget build(BuildContext context) {
    final bool isLastPage = currentIndex == itemCount - 1;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(48.r),
          topRight: Radius.circular(48.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black100.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const OnBoardingBrandLogoWidget(),
                    if (!isLastPage)
                      Positioned(
                        right: 0,
                        child: OnBoardingSkipButtonWidget(
                          onPressed: onSkipPressed,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary700,
                  height: 1.25,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                item.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black100,
                  height: 1.4,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 20.h),
              AppElevatedButton(
                title: isLastPage ? 'Get Started' : 'Next',
                onPressed: onNextPressed,
                height: 56,
                borderRadius: 16,
                backgroundColor: AppColors.primary700,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
