import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/home/domain/usecases/get_current_project_overview_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/get_project_bids_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/get_recommended_contractors_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/marketplace_state.dart';

class MarketplaceCubit extends Cubit<MarketplaceState> {
  final GetCurrentProjectOverviewUseCase getCurrentProjectOverviewUseCase;
  final GetRecommendedContractorsUseCase getRecommendedContractorsUseCase;
  final GetProjectBidsUseCase getProjectBidsUseCase;

  MarketplaceCubit({
    required this.getCurrentProjectOverviewUseCase,
    required this.getRecommendedContractorsUseCase,
    required this.getProjectBidsUseCase,
  }) : super(const MarketplaceState());

  Future<void> initMarketplace() async {
    // Reset to loading state for both
    emit(state.copyWith(
      contractorsState: RequestState.loading,
      bidsState: RequestState.loading,
    ));

    final overviewResult = await getCurrentProjectOverviewUseCase();
    
    overviewResult.fold(
      (data) {
        if (!data.hasActiveProject) {
          // If no active project, show empty for both
          emit(state.copyWith(
            contractorsState: RequestState.empty,
            bidsState: RequestState.empty,
          ));
        } else {
          final projectId = data.projectId!;
          fetchRecommendedContractors(projectId);
          fetchProjectBids(projectId);
        }
      },
      (failure) {
        emit(state.copyWith(
          contractorsState: RequestState.error,
          contractorsErrorMessage: failure.errMessage,
          bidsState: RequestState.error,
          bidsErrorMessage: failure.errMessage,
        ));
      },
    );
  }

  Future<void> fetchRecommendedContractors(String projectId) async {
    final result = await getRecommendedContractorsUseCase(projectId);
    result.fold(
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(contractorsState: RequestState.empty));
        } else {
          emit(state.copyWith(
            contractorsState: RequestState.loaded,
            contractors: data,
          ));
        }
      },
      (failure) {
        emit(state.copyWith(
          contractorsState: RequestState.error,
          contractorsErrorMessage: failure.errMessage,
        ));
      },
    );
  }

  Future<void> fetchProjectBids(
    String projectId, {
    String? sortBy,
    double? maxCost,
    int? maxDurationDays,
  }) async {
    // If not initial load, we might want to emit loading state again
    emit(state.copyWith(bidsState: RequestState.loading));
    
    final result = await getProjectBidsUseCase(
      GetProjectBidsParams(
        projectId: projectId,
        sortBy: sortBy,
        maxCost: maxCost,
        maxDurationDays: maxDurationDays,
      ),
    );
    
    result.fold(
      (data) {
        if (data.isEmpty) {
          emit(state.copyWith(bidsState: RequestState.empty));
        } else {
          emit(state.copyWith(
            bidsState: RequestState.loaded,
            bids: data,
          ));
        }
      },
      (failure) {
        emit(state.copyWith(
          bidsState: RequestState.error,
          bidsErrorMessage: failure.errMessage,
        ));
      },
    );
  }
}
