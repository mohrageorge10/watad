import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'package:watad/features/dashboard/owner/feasibility/presentation/cubit/feasibility_cubit.dart';
import '../sections/feasibility_report_section.dart';

class FeasibilityReportView extends StatelessWidget {
  final FeasibilityReport report;

  const FeasibilityReportView({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FeasibilityCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFF),
        body: SafeArea(
          child: FeasibilityReportSection(report: report),
        ),
      ),
    );
  }
}
