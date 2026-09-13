import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/home/domain/usecases/get_current_project_overview_usecase.dart';
import '../../domain/usecases/get_financial_summary_usecase.dart';
import 'financial_summary_state.dart';

class FinancialSummaryCubit extends Cubit<FinancialSummaryState> {
  final GetFinancialSummaryUseCase getFinancialSummaryUseCase;
  final GetCurrentProjectOverviewUseCase getCurrentProjectOverviewUseCase;

  FinancialSummaryCubit({
    required this.getFinancialSummaryUseCase,
    required this.getCurrentProjectOverviewUseCase,
  }) : super(FinancialSummaryInitial());

  Future<void> fetchSummaryData() async {
    emit(FinancialSummaryLoading());
    
    final overviewResult = await getCurrentProjectOverviewUseCase();
    String? projectId;
    bool hasError = false;

    overviewResult.fold(
      (data) {
        if (!data.hasActiveProject || data.projectId == null || data.projectId!.isEmpty) {
          emit(FinancialSummaryError('No active project found'));
          hasError = true;
        } else {
          projectId = data.projectId;
        }
      },
      (failure) {
        emit(FinancialSummaryError(failure.errMessage));
        hasError = true;
      },
    );

    if (hasError || projectId == null) return;

    final result = await getFinancialSummaryUseCase(projectId!);
    
    result.fold(
      (data) => emit(FinancialSummaryLoaded(data)),
      (failure) => emit(FinancialSummaryError(failure.errMessage)),
    );
  }
}
