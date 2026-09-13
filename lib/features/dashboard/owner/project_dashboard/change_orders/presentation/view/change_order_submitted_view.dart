import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';

class ChangeOrderSubmittedView extends StatelessWidget {
  final String orderId;

  const ChangeOrderSubmittedView({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white100,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            context.go(AppRoutes.changeOrders);
          },
        ),
        centerTitle: true,
        title: Text(
          "Change Orders",
          style: AppTextStyles.font16SemiBold.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.r),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 64.h),
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  color: AppColors.success,
                  size: 64.w,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                "Your change order has been submitted successfully!",
                textAlign: TextAlign.center,
                style: AppTextStyles.font20SemiBold.copyWith(
                  color: AppColors.grey900,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "It is now pending approval. You can track its status in the pending orders list.",
                textAlign: TextAlign.center,
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.grey500,
                ),
              ),
              SizedBox(height: 32.h),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: AppElevatedButton(
                  title: "View My Requests",
                  textStyle: AppTextStyles.font14MediumWhite,
                  onPressed: () {
                    context.go(AppRoutes.changeOrders);
                  },
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
