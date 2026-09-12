import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';
import 'package:watad/core/shared/widgets/app_empty_state_widget.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/domain/entities/change_order_details.dart';
import '../cubit/change_order_details_cubit.dart';
import '../cubit/change_order_details_state.dart';
import '../widgets/change_order_formatters.dart';
import '../widgets/change_order_status_badge.dart';

class ChangeOrderDetailsView extends StatelessWidget {
  final String orderId;
  final bool isPending;

  const ChangeOrderDetailsView({
    super.key,
    required this.orderId,
    this.isPending = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChangeOrderDetailsCubit>()..getDetails(orderId),
      child: Scaffold(
        backgroundColor: AppColors.white100,
        appBar: AppBar(
          backgroundColor: AppColors.white100,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 20.w),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Change Order Details',
            style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary),
          ),
          centerTitle: true,
          shape: Border(bottom: BorderSide(color: AppColors.grey300, width: 1.h)),
        ),
        body: BlocBuilder<ChangeOrderDetailsCubit, ChangeOrderDetailsState>(
          builder: (context, state) {
            if (state is ChangeOrderDetailsLoading || state is ChangeOrderDetailsInitial) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            if (state is ChangeOrderDetailsError) {
              return AppEmptyStateWidget(
                title: 'Error',
                message: state.message,
              );
            }
            if (state is ChangeOrderDetailsLoaded) {
              return _buildContent(context, state.details);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ChangeOrderDetails details) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Description',
                style: AppTextStyles.font18SemiBoldDark.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              ChangeOrderStatusBadge(status: details.status),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            details.description,
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.grey600,
              height: 1.5,
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.white100,
                    border: Border.all(color: AppColors.accept),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cost Impact',
                        style: AppTextStyles.font12MediumGrey.copyWith(color: AppColors.accept),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        ChangeOrderFormatters.costImpact(details.costImpact),
                        style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.accept),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.white100,
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time Impact',
                        style: AppTextStyles.font12MediumGrey.copyWith(color: AppColors.primary),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        ChangeOrderFormatters.daysImpact(details.timeImpactDays),
                        style: AppTextStyles.font16SemiBold.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildInfoRow('Requested by', 'Contractor', 'assets/icons/ic_user.svg'),
          SizedBox(height: 16.h),
          _buildInfoRow('Requested on', ChangeOrderFormatters.date(details.createdAt), 'assets/icons/ic_calendar.svg'),
          SizedBox(height: 16.h),
          _buildInfoRow('Related To', 'Foundation Works', 'assets/icons/ic_project.svg'),
          SizedBox(height: 24.h),
          if (isPending) ...[
            SizedBox(height: 48.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 46.h,
                    child: AppElevatedButton(
                      title: 'Reject',
                      onPressed: () {
                        context.push(AppRoutes.confirmRejectChangeOrder, extra: details);
                      },
                      backgroundColor: AppColors.white100,
                      textStyle: AppTextStyles.btnWhite600.copyWith(color: AppColors.alert),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SizedBox(
                    height: 46.h,
                    child: AppElevatedButton(
                      title: 'Accept',
                      onPressed: () {
                        context.push(AppRoutes.confirmAcceptChangeOrder, extra: details);
                      },
                      backgroundColor: AppColors.accept,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, String iconPath) {
    return Row(
      children: [
        Icon(Icons.info_outline, color: AppColors.grey50, size: 20.w), // Placeholder for actual icon
        SizedBox(width: 8.w),
        Text(
          title,
          style: AppTextStyles.font14Regular.copyWith(color: AppColors.primary),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.font14SemiBoldDark,
        ),
      ],
    );
  }
}
