import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/home/domain/usecases/get_current_project_overview_usecase.dart';
import '../../domain/usecases/get_progress_site_updates_usecase.dart';
import 'progress_site_updates_state.dart';

class ProgressSiteUpdatesCubit extends Cubit<ProgressSiteUpdatesState> {
  final GetProgressSiteUpdatesUseCase getProgressSiteUpdatesUseCase;
  final GetCurrentProjectOverviewUseCase getCurrentProjectOverviewUseCase;

  ProgressSiteUpdatesCubit({
    required this.getProgressSiteUpdatesUseCase,
    required this.getCurrentProjectOverviewUseCase,
  }) : super(ProgressSiteUpdatesInitial());

  Future<void> fetchProgressSiteUpdates() async {
    emit(ProgressSiteUpdatesLoading());
    
    final overviewResult = await getCurrentProjectOverviewUseCase();
    String? projectId;
    bool hasError = false;

    overviewResult.fold(
      (data) {
        if (!data.hasActiveProject || data.projectId == null || data.projectId!.isEmpty) {
          emit(ProgressSiteUpdatesError('No active project found'));
          hasError = true;
        } else {
          projectId = data.projectId;
        }
      },
      (failure) {
        emit(ProgressSiteUpdatesError(failure.errMessage));
        hasError = true;
      },
    );

    if (hasError || projectId == null) return;

    final result = await getProgressSiteUpdatesUseCase(projectId!);
    
    result.fold(
      (data) => emit(ProgressSiteUpdatesLoaded(data)),
      (failure) => emit(ProgressSiteUpdatesError(failure.errMessage)),
    );
  }
}
