import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:watad/core/routing/app_routes.dart';
import 'package:watad/core/shared/widgets/app_confirmation_dialog.dart';
import 'package:watad/core/shared/widgets/app_toast.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_state.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/edit_profile_form_section.dart';
import 'package:watad/features/contractor/profile/presentation/view/sections/edit_profile_header_section.dart';

class EditProfileScreen extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final ContractorProfileCubit? cubit;

  const EditProfileScreen({
    super.key,
    this.onBackTap,
    this.onSettingsTap,
    this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    ContractorProfileCubit? activeCubit = cubit;
    try {
      activeCubit ??= context.read<ContractorProfileCubit>();
    } catch (_) {
      // Fallback
    }

    final currentProfile = (activeCubit?.state is ContractorProfileSuccess)
        ? (activeCubit!.state as ContractorProfileSuccess).profile
        : null;

    return Scaffold(
      backgroundColor: AppColors.white100,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditProfileHeaderSection(
              onBackTap: onBackTap ?? () => context.pop(),
              onSettingsTap: onSettingsTap,
            ),
            EditProfileFormSection(
              initialProfile: currentProfile,
              onSave: ({
                required String name,
                required String companyName,
                required String specialization,
                required String experience,
                required List<String> governorates,
                required String bio,
                String? commercialRegister,
                String? taxId,
              }) async {
                if (activeCubit != null) {
                  final error = await activeCubit.updateProfile(
                    name: name,
                    companyName: companyName,
                    yearsOfExperience: experience,
                    aboutMe: bio,
                    specializations: [specialization],
                    coveredGovernorates: governorates,
                    commercialRegister: commercialRegister,
                    taxCard: taxId,
                  );

                  if (context.mounted) {
                    if (error != null) {
                      AppToast.showError(context, error);
                    } else {
                      AppToast.showSuccess(
                        context,
                        'Profile updated successfully!',
                      );

                      // Prompt dialog to add first portfolio project
                      final wantToAdd = await AppConfirmationDialog.show(
                        context,
                        title: 'إضافة سابقة أعمال',
                        message: 'هل ترغب في إضافة أول مشروع لك في سابقة الأعمال؟',
                        icon: Icons.work_outline_rounded,
                        iconColor: AppColors.primary,
                        cancelText: 'تخطي الآن',
                        confirmText: 'إضافة مشروع',
                        confirmButtonColor: AppColors.primary,
                      );

                      if (context.mounted) {
                        if (wantToAdd == true) {
                          context.pushReplacement(AppRoutes.addPortfolioProject);
                        } else {
                          context.pop(true);
                        }
                      }
                    }
                  }
                }
              },
              onCancel: () => context.pop(),
            ),
          ],
        ),
      ),
      // No bottomNavigationBar on Edit Profile screen as requested
    );
  }
}
