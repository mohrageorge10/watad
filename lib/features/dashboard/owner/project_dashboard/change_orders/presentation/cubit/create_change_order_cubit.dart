import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/home/domain/usecases/get_current_project_overview_usecase.dart';
import '../../domain/usecases/create_change_order_usecase.dart';
import 'create_change_order_state.dart';

class CreateChangeOrderCubit extends Cubit<CreateChangeOrderState> {
  final CreateChangeOrderUseCase createChangeOrderUseCase;
  final GetCurrentProjectOverviewUseCase getCurrentProjectOverviewUseCase;

  CreateChangeOrderCubit({
    required this.createChangeOrderUseCase,
    required this.getCurrentProjectOverviewUseCase,
  }) : super(CreateChangeOrderInitial());

  Future<void> createOrder({
    required String description,
    required num costImpact,
    required int timeImpactDays,
  }) async {
    emit(CreateChangeOrderLoading());

    final overviewResult = await getCurrentProjectOverviewUseCase();
    String? projectId;
    bool hasError = false;

    overviewResult.fold(
      (data) {
        if (!data.hasActiveProject || data.projectId == null || data.projectId!.isEmpty) {
          emit(CreateChangeOrderError('No active project found'));
          hasError = true;
        } else {
          projectId = data.projectId;
        }
      },
      (failure) {
        emit(CreateChangeOrderError(failure.errMessage));
        hasError = true;
      },
    );

    if (hasError || projectId == null) return;

    final result = await createChangeOrderUseCase(projectId!, description, costImpact, timeImpactDays);

    result.fold(
      (id) => emit(CreateChangeOrderSuccess(id)),
      (error) => emit(CreateChangeOrderError(error.errMessage)),
    );
  }
}
