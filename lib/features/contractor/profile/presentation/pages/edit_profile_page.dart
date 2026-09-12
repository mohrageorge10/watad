import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';
import 'package:watad/features/contractor/profile/presentation/pages/edit_profile_screen.dart';

class EditProfilePage extends StatelessWidget {
  final VoidCallback? onBackTap;
  final VoidCallback? onSettingsTap;
  final ContractorProfileCubit? cubit;

  const EditProfilePage({
    super.key,
    this.onBackTap,
    this.onSettingsTap,
    this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    if (cubit != null) {
      return BlocProvider.value(
        value: cubit!,
        child: EditProfileScreen(
          onBackTap: onBackTap,
          onSettingsTap: onSettingsTap,
          cubit: cubit,
        ),
      );
    }

    return BlocProvider(
      create: (context) => sl<ContractorProfileCubit>()..loadProfile(),
      child: EditProfileScreen(
        onBackTap: onBackTap,
        onSettingsTap: onSettingsTap,
      ),
    );
  }
}
