import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/contractor/project_dashboard/domain/usecases/get_contractor_project_dashboard_usecase.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/cubit/contractor_project_dashboard_state.dart';

class ContractorProjectDashboardCubit
    extends Cubit<ContractorProjectDashboardState> {
  final GetContractorProjectDashboardUseCase getProjectDashboardUseCase;

  ContractorProjectDashboardCubit({
    required this.getProjectDashboardUseCase,
  }) : super(ContractorProjectDashboardInitial());

  Future<void> loadDashboard(String projectId) async {
    emit(ContractorProjectDashboardLoading());

    final result = await getProjectDashboardUseCase(projectId);

    result.fold(
      (dashboard) {
        emit(ContractorProjectDashboardSuccess(dashboard));
      },
      (failure) {
        emit(ContractorProjectDashboardError(failure.errMessage));
      },
    );
  }
}
