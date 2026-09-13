import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/shared/widgets/app_text_field.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/shared/widgets/app_elevated_button.dart';

import '../cubit/create_change_order_cubit.dart';
import '../cubit/create_change_order_state.dart';

class CreateChangeOrderView extends StatefulWidget {
  const CreateChangeOrderView({super.key});

  @override
  State<CreateChangeOrderView> createState() => _CreateChangeOrderViewState();
}

class _CreateChangeOrderViewState extends State<CreateChangeOrderView> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _durationController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    _costController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (context.read<CreateChangeOrderCubit>().state is CreateChangeOrderLoading) return;
    
    if (_formKey.currentState!.validate()) {
      context.read<CreateChangeOrderCubit>().createOrder(
            description: _descriptionController.text,
            costImpact: num.parse(_costController.text),
            timeImpactDays: int.parse(_durationController.text),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CreateChangeOrderCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.secondBackground,
        appBar: AppBar(
          backgroundColor: AppColors.white100,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
            onPressed: () => context.pop(),
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
          child: BlocConsumer<CreateChangeOrderCubit, CreateChangeOrderState>(
            listener: (context, state) {
              if (state is CreateChangeOrderSuccess) {
                context.pushReplacement(
                  AppRoutes.changeOrderSubmitted,
                  extra: state.orderId,
                );
              } else if (state is CreateChangeOrderError) {
                AppToast.showError(context, state.message);
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900),
                      ),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _descriptionController,
                        hintText: "Enter description",
                        maxLines: 4,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Description is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Requested Cost (EGP)",
                        style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900),
                      ),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _costController,
                        hintText: "EGP 0.00",
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Requested Cost is required";
                          }
                          if (num.tryParse(val) == null) {
                            return "Enter a valid number";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Requested Duration (Days)",
                        style: AppTextStyles.font14Medium.copyWith(color: AppColors.grey900),
                      ),
                      SizedBox(height: 8.h),
                      AppTextField(
                        controller: _durationController,
                        hintText: "+0 Days",
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Requested Duration is required";
                          }
                          if (int.tryParse(val) == null) {
                            return "Enter a valid integer";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32.h),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: state is CreateChangeOrderLoading
                            ? const Center(child: CircularProgressIndicator())
                            : AppElevatedButton(
                                title: "Submit for Approval",
                                textStyle: AppTextStyles.font14MediumWhite,
                                onPressed: () => _submit(context),
                              ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
