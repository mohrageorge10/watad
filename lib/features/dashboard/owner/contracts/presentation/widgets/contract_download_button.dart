import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/contracts/data/models/contract_details_dto.dart';
import 'package:watad/features/dashboard/owner/contracts/presentation/cubit/contract_details_cubit.dart';

class ContractDownloadButton extends StatelessWidget {
  final ContractDetailsDto contract;

  const ContractDownloadButton({
    super.key,
    required this.contract,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractDetailsCubit, ContractDetailsState>(
      buildWhen: (previous, current) =>
          current is ContractPdfLoading ||
          current is ContractPdfSuccess ||
          current is ContractPdfError,
      builder: (context, state) {
        final isLoading = state is ContractPdfLoading;
        return ElevatedButton(
          onPressed: isLoading
              ? null
              : () {
                  context.read<ContractDetailsCubit>().generateAndDownloadPdf(
                        contract.projectId.toString(),
                        contract.id.toString(),
                      );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: Size(double.infinity, 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white100,
                  ),
                )
              : Text(
                  'Download Contract PDF',
                  style: AppTextStyles.font16SemiBold.copyWith(
                    color: AppColors.white100,
                  ),
                ),
        );
      },
    );
  }
}
