import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/cubit/create_contract_cubit.dart';

class CreateContractView extends StatefulWidget {
  final String bidId;

  const CreateContractView({
    super.key,
    required this.bidId,
  });

  @override
  State<CreateContractView> createState() => _CreateContractViewState();
}

class _CreateContractViewState extends State<CreateContractView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = sl<CreateContractCubit>();
        cubit.bidId = widget.bidId;
        cubit.loadBidDetails();
        return cubit;
      },
      child: const _CreateContractBody(),
    );
  }
}

class _CreateContractBody extends StatelessWidget {
  const _CreateContractBody();

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
                  'Create Contract',
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
      body: BlocConsumer<CreateContractCubit, CreateContractState>(
        listener: (context, state) {
          if (state is CreateContractError) {
            AppToast.showError(context, state.message);
          } else if (state is CreateContractSuccess) {
            AppToast.showSuccess(context, 'Contract created successfully');
            context.pushReplacementNamed(
              'contract_details',
              extra: state.contractId,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<CreateContractCubit>();
          if (cubit.isFetchingBidDetails) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary700));
          }
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContractorSection(cubit),
                SizedBox(height: 24.h),
                _buildMilestonesSection(context, cubit),
                SizedBox(height: 24.h),
                _buildDateSection(
                  context: context,
                  title: 'Start Date',
                  value: cubit.startDate,
                  onDateSelected: (date) {
                    cubit.startDate = date;
                    cubit.refreshUI();
                  },
                ),
                SizedBox(height: 24.h),
                _buildDateSection(
                  context: context,
                  title: 'End Date',
                  value: cubit.endDate,
                  onDateSelected: (date) {
                    cubit.endDate = date;
                    cubit.refreshUI();
                  },
                ),
                SizedBox(height: 24.h),
                _buildTotalValueSection(cubit),
                SizedBox(height: 24.h),
                _buildTermsSection(cubit),
                SizedBox(height: 32.h),
                _buildCreateButton(cubit, state),
                SizedBox(height: 40.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContractorSection(CreateContractCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.contact_page_outlined, color: AppColors.primary700, size: 20),
            SizedBox(width: 8.w),
            Text(
              'Contractor',
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.grey900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.white100,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.grey200),
          ),
          child: Row(
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.grey200, // Fallback color
                ),
                clipBehavior: Clip.antiAlias,
                child: const Icon(
                  Icons.business_outlined, // Replaced logo with icon as requested
                  color: AppColors.primary700,
                  size: 24,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cubit.bidDetails?.contractorName ?? '',
                      style: AppTextStyles.font14SemiBoldDark.copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      cubit.bidDetails?.contractorEmail ?? '',
                      style: AppTextStyles.font14Regular.copyWith(color: AppColors.grey500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMilestonesSection(BuildContext context, CreateContractCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.sync, color: AppColors.primary700, size: 20),
            SizedBox(width: 8.w),
            Text(
              'Payment Milestones',
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                color: AppColors.primary700,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () async {
            final result = await context.pushNamed(AppRoutes.milestonesForm);
            if (result != null) {
              cubit.addMilestone(result as dynamic);
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primary700), // Highlighted border in design? Actually it looks grey in design. Wait, in design, the text is blue, border is grey.
            ),
            child: Row(
              children: [
                const Icon(Icons.sync, color: AppColors.primary700, size: 24),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add /Manage Milestones',
                        style: AppTextStyles.font14SemiBoldDark.copyWith(
                          color: AppColors.primary700,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        cubit.milestones.isEmpty
                            ? 'No milestones added yet'
                            : '${cubit.milestones.length} Milestone${cubit.milestones.length > 1 ? 's' : ''} Added — '
                              '${cubit.milestones.fold<num>(0, (sum, m) => sum + m.costPercentage).toInt()}% total',
                        style: AppTextStyles.font12RegularGrey.copyWith(
                          color: cubit.milestones.fold<num>(0, (sum, m) => sum + m.costPercentage) == 100
                              ? Colors.green
                              : AppColors.grey500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.grey400),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSection({
    required BuildContext context,
    required String title,
    required String value,
    required Function(String) onDateSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_today_outlined, color: AppColors.primary700, size: 18),
            SizedBox(width: 8.w),
            Text(
              title,
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                color: AppColors.primary700,
                fontWeight: FontWeight.w700,
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
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
              onDateSelected("${date.day} ${months[date.month - 1]} ${date.year}");
            }
          },
          child: Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white100,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.grey200),
            ),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: AppColors.grey400, size: 20),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    value.isEmpty ? 'Select Date' : value,
                    style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey500),
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

  Widget _buildTotalValueSection(CreateContractCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.monetization_on_outlined, color: AppColors.primary700, size: 20),
            SizedBox(width: 8.w),
            Text(
              'Total Contract Value (EGP)',
              style: AppTextStyles.font14SemiBoldDark.copyWith(
                color: AppColors.primary700,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        TextFormField(
          initialValue: cubit.totalValue > 0 ? cubit.totalValue.toString() : '',
          keyboardType: TextInputType.number,
          onChanged: (value) {
            cubit.totalValue = num.tryParse(value) ?? 0;
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.payments_outlined, color: AppColors.grey400, size: 20),
            suffixText: 'EGP',
            suffixStyle: AppTextStyles.font14Medium.copyWith(color: AppColors.grey500),
            hintText: 'Enter total value',
            hintStyle: AppTextStyles.font14Medium.copyWith(color: AppColors.grey400),
            filled: true,
            fillColor: AppColors.white100,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.grey200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.grey200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.primary700),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsSection(CreateContractCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms and Conditions',
          style: AppTextStyles.font14SemiBoldDark.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.grey900,
          ),
        ),
        SizedBox(height: 12.h),
        TextField(
          maxLines: 5,
          maxLength: 500,
          onChanged: (value) {
            cubit.termsAndConditions = value;
          },
          decoration: InputDecoration(
            hintText: 'Enter terms and Conditions',
            hintStyle: AppTextStyles.font14Medium.copyWith(color: AppColors.grey400),
            filled: true,
            fillColor: AppColors.white100,
            contentPadding: EdgeInsets.all(16.r),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.grey200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.grey200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary700),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton(CreateContractCubit cubit, CreateContractState state) {
    return GestureDetector(
      onTap: () {
        cubit.submitContract();
      },
      child: Container(
        height: 52.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary700,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state is CreateContractLoading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: AppColors.white100, strokeWidth: 2),
              )
            else
              const Icon(Icons.add_circle_outline, color: AppColors.white100, size: 20),
            SizedBox(width: 8.w),
            Text(
              'Create Contract',
              style: AppTextStyles.btnWhite600.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
