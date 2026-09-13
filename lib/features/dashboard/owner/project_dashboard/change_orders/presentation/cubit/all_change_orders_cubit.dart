import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/home/domain/usecases/get_current_project_overview_usecase.dart';
import '../../domain/usecases/get_all_change_orders_usecase.dart';
import 'all_change_orders_state.dart';

class AllChangeOrdersCubit extends Cubit<AllChangeOrdersState> {
  final GetAllChangeOrdersUseCase getAllChangeOrdersUseCase;
  final GetCurrentProjectOverviewUseCase getCurrentProjectOverviewUseCase;

  AllChangeOrdersCubit({
    required this.getAllChangeOrdersUseCase,
    required this.getCurrentProjectOverviewUseCase,
  }) : super(AllChangeOrdersInitial());

  Future<void> loadChangeOrders() async {
    emit(AllChangeOrdersLoading());
    
    final overviewResult = await getCurrentProjectOverviewUseCase();
    String? projectId;
    bool hasError = false;

    overviewResult.fold(
      (data) {
        if (!data.hasActiveProject || data.projectId == null || data.projectId!.isEmpty) {
          emit(AllChangeOrdersError('No active project found'));
          hasError = true;
        } else {
          projectId = data.projectId;
        }
      },
      (failure) {
        emit(AllChangeOrdersError(failure.errMessage));
        hasError = true;
      },
    );

    if (hasError || projectId == null) return;

    final result = await getAllChangeOrdersUseCase(projectId!);
    
    result.fold(
      (data) {
        if (data.pendingOrders.isEmpty && data.stats.totalOrders == 0) {
          emit(AllChangeOrdersEmpty());
        } else {
          emit(AllChangeOrdersLoaded(data));
        }
      },
      (failure) => emit(AllChangeOrdersError(failure.errMessage)),
    );
  }
}
