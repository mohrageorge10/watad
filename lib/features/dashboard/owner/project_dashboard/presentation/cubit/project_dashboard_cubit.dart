import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/home/domain/usecases/get_current_project_overview_usecase.dart';
import '../../domain/usecases/get_project_dashboard_usecase.dart';
import 'project_dashboard_state.dart';

class ProjectDashboardCubit extends Cubit<ProjectDashboardState> {
  final GetProjectDashboardUseCase getProjectDashboardUseCase;
  final GetCurrentProjectOverviewUseCase getCurrentProjectOverviewUseCase;

  ProjectDashboardCubit({
    required this.getProjectDashboardUseCase,
    required this.getCurrentProjectOverviewUseCase,
  }) : super(ProjectDashboardInitial());

  String? _currentProjectId;

  Future<void> fetchDashboardData([String? projectId]) async {
    emit(ProjectDashboardLoading());

    String? id = projectId ?? _currentProjectId;

    if (id == null || id.isEmpty) {
      final overviewResult = await getCurrentProjectOverviewUseCase();
      bool hasError = false;

      overviewResult.fold(
        (data) {
          if (!data.hasActiveProject || data.projectId == null || data.projectId!.isEmpty) {
            emit(ProjectDashboardEmpty());
            hasError = true;
          } else {
            id = data.projectId;
          }
        },
        (failure) {
          emit(ProjectDashboardError(failure.errMessage));
          hasError = true;
        },
      );

      if (hasError || id == null || id!.isEmpty) return;
    }

    _currentProjectId = id;
    final result = await getProjectDashboardUseCase(id!);

    result.fold(
      (data) => emit(ProjectDashboardLoaded(data)),
      (failure) => emit(ProjectDashboardError(failure.errMessage)),
    );
  }
}
