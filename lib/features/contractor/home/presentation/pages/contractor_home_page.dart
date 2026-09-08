import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_home_cubit.dart';
import 'package:watad/features/contractor/home/presentation/pages/contractor_home_view.dart';

class ContractorHomePage extends StatelessWidget {
  const ContractorHomePage({
    super.key,
    this.onNavigateToMarketplace,
    this.onNavigateToProfile,
  });

  final VoidCallback? onNavigateToMarketplace;
  final VoidCallback? onNavigateToProfile;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContractorHomeCubit>()..loadHomeData(),
      child: ContractorHomeView(
        onNavigateToMarketplace: onNavigateToMarketplace,
        onNavigateToProfile: onNavigateToProfile,
      ),
    );
  }
}
