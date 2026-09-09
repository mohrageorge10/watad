import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/features/dashboard/owner/feasibility/presentation/cubit/feasibility_cubit.dart';
import '../sections/feasibility_calculator_section.dart';

class FeasibilityCalculatorView extends StatelessWidget {
  const FeasibilityCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FeasibilityCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFF),
        body: const SafeArea(
          child: FeasibilityCalculatorSection(),
        ),
      ),
    );
  }
}
