import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/theme/app_colors.dart';
import 'package:watad/core/theme/app_text_styles.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_overview_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_overview_state.dart';
import 'package:watad/features/dashboard/owner/home/presentation/widgets/current_project_card.dart';
import 'package:watad/features/dashboard/owner/home/presentation/widgets/overview_shimmer.dart';
import 'package:watad/features/dashboard/owner/home/presentation/widgets/start_feasibility_promo_card.dart';


class HomeCurrentProjectSection extends StatelessWidget {
  const HomeCurrentProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeOverviewCubit, HomeOverviewState>(
      builder: (context, state) {
        if (state is HomeOverviewLoading || state is HomeOverviewInitial) {
          return const CurrentProjectOverviewShimmer();
        }

        if (state is HomeOverviewLoaded) {
          return CurrentProjectCard(
            overview: state.data,
            onGoToDashboard: () {
              // TODO: context.pushNamed(Routes.projectDashboard, arguments: state.data.projectId);
            },
          );
        }

        if (state is HomeOverviewEmpty) {
          return StartFeasibilityPromoCard(
            onCalculateNow: () {
              // TODO: context.pushNamed(Routes.feasibilityCalculator);
            },
          );
        }

        if (state is HomeOverviewError) {
          return _OverviewErrorRetry(
            message: state.message,
            onRetry: () => context.read<HomeOverviewCubit>().fetchOverview(),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _OverviewErrorRetry extends StatelessWidget {
  const _OverviewErrorRetry({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(message, style: AppTextStyles.font14Regular.copyWith(color: AppColors.alert)),
        TextButton(onPressed: onRetry, child: const Text('Retry')),
      ],
    );
  }
}
