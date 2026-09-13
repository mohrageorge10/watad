import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/domain/entities/change_order_details.dart';
import '../cubit/change_order_details_cubit.dart';
import '../cubit/change_order_details_state.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/shared/widgets/app_text_field.dart';

class ConfirmRejectChangeOrderView extends StatelessWidget {
  final ChangeOrderDetails order;

  const ConfirmRejectChangeOrderView({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangeOrderDetailsCubit>(),
      child: ConfirmRejectChangeOrderBody(order: order),
    );
  }
}

class ConfirmRejectChangeOrderBody extends StatefulWidget {
  final ChangeOrderDetails order;

  const ConfirmRejectChangeOrderBody({super.key, required this.order});

  @override
  State<ConfirmRejectChangeOrderBody> createState() => _ConfirmRejectChangeOrderBodyState();
}

class _ConfirmRejectChangeOrderBodyState extends State<ConfirmRejectChangeOrderBody> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _onReject(BuildContext context) {
    final reason = _reasonController.text.trim();
    if (reason.isEmpty) {
      AppToast.showError(context, 'Please add a reason for rejection.');
      return;
    }
    context.read<ChangeOrderDetailsCubit>().rejectChangeOrder(widget.order.id, reason);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      appBar: AppBar(
        backgroundColor: AppColors.white100,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 20.w),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Confirm Decision',
          style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary),
        ),
        centerTitle: true,
        shape: Border(bottom: BorderSide(color: AppColors.grey300, width: 1.h)),
      ),
      body: BlocConsumer<ChangeOrderDetailsCubit, ChangeOrderDetailsState>(
        listener: (context, state) {
          if (state is ChangeOrderDecisionSuccess) {
            AppToast.showSuccess(context, 'Change order rejected successfully');
            context.go(AppRoutes.projectDashboard); // Or to a reject success page if needed, for now back to dashboard
          } else if (state is ChangeOrderDecisionError) {
            AppToast.showError(context, state.message);
          }
        },
        builder: (context, state) {
          final isLoading = state is ChangeOrderDecisionLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24.h),
                Container(
                  width: 80.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.alert.withValues(alpha: 0.1),
                  ),
                  child: Center(
                    child: Icon(Icons.close, color: AppColors.alert, size: 40.w),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Reject Change Order',
                  style: AppTextStyles.font18SemiBoldDark.copyWith(color: AppColors.primary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  'You are about to reject this change order.\nPlease add a reason',
                  style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey50),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Reason ',
                      style: AppTextStyles.font14SemiBoldDark.copyWith(color: AppColors.primary),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(color: AppColors.alert),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                AppTextField(
                  controller: _reasonController,
                  hintText: 'Add reason for rejection...',
                  maxLines: 5,
                  readOnly: isLoading,
                ),
                SizedBox(height: 48.h),
                Row(
                  children: [
                    Expanded(
                      child: AppElevatedButton(
                        title: 'Cancel',
                        onPressed: isLoading ? null : () => context.pop(),
                        backgroundColor: AppColors.white100,
                        textStyle: AppTextStyles.btnWhite600.copyWith(color: AppColors.black100),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: AppElevatedButton(
                        title: 'Confirm Reject',
                        onPressed: isLoading ? null : () => _onReject(context),
                        backgroundColor: AppColors.alert,
                        isLoading: isLoading,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
