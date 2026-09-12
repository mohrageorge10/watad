import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/home/domain/usecases/get_current_project_overview_usecase.dart';
import '../../domain/usecases/get_change_orders_usecase.dart';
import 'change_orders_state.dart';

class ChangeOrdersCubit extends Cubit<ChangeOrdersState> {
  final GetChangeOrdersUseCase getChangeOrdersUseCase;
  final GetCurrentProjectOverviewUseCase getCurrentProjectOverviewUseCase;

  ChangeOrdersCubit({
    required this.getChangeOrdersUseCase,
    required this.getCurrentProjectOverviewUseCase,
  }) : super(ChangeOrdersInitial());

  Future<void> fetchChangeOrders() async {
    emit(ChangeOrdersLoading());
    
    final overviewResult = await getCurrentProjectOverviewUseCase();
    String? projectId;
    bool hasError = false;

    overviewResult.fold(
      (data) {
        if (!data.hasActiveProject || data.projectId == null || data.projectId!.isEmpty) {
          emit(ChangeOrdersError('No active project found'));
          hasError = true;
        } else {
          projectId = data.projectId;
        }
      },
      (failure) {
        emit(ChangeOrdersError(failure.errMessage));
        hasError = true;
      },
    );

    if (hasError || projectId == null) return;

    final result = await getChangeOrdersUseCase(projectId!);
    
    result.fold(
      (data) => emit(ChangeOrdersLoaded(data)),
      (failure) => emit(ChangeOrdersError(failure.errMessage)),
    );
  }
}
