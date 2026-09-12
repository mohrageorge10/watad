import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';
import 'package:watad/features/contractor/profile/presentation/pages/contractor_profile_screen.dart';

class ContractorProfilePage extends StatelessWidget {
  final VoidCallback? onSettingsTap;
  final VoidCallback? onNavigateToMyProjects;
  final bool showBottomNavBar;

  const ContractorProfilePage({
    super.key,
    this.onSettingsTap,
    this.onNavigateToMyProjects,
    this.showBottomNavBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContractorProfileCubit>()..loadProfile(),
      child: ContractorProfileScreen(
        onSettingsTap: onSettingsTap,
        onNavigateToMyProjects: onNavigateToMyProjects,
        showBottomNavBar: showBottomNavBar,
      ),
    );
  }
}
