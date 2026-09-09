import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/project_dashboard_repository.dart';
import 'project_dashboard_state.dart';

class ProjectDashboardCubit extends Cubit<ProjectDashboardState> {
  final ProjectDashboardRepository _repository;

  ProjectDashboardCubit(this._repository) : super(ProjectDashboardInitial());

  Future<void> fetchDashboardData(String projectId) async {
    emit(ProjectDashboardLoading());
    try {
      final data = await _repository.getDashboardData(projectId);
      emit(ProjectDashboardLoaded(data));
    } catch (e) {
      emit(ProjectDashboardError(e.toString()));
    }
  }
}
