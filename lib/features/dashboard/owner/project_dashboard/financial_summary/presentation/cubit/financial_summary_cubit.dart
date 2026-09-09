import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/financial_summary_repository.dart';
import 'financial_summary_state.dart';

class FinancialSummaryCubit extends Cubit<FinancialSummaryState> {
  final FinancialSummaryRepository _repository;

  FinancialSummaryCubit(this._repository) : super(FinancialSummaryInitial());

  Future<void> fetchSummaryData(String projectId) async {
    emit(FinancialSummaryLoading());
    try {
      final data = await _repository.getFinancialSummary(projectId);
      emit(FinancialSummaryLoaded(data));
    } catch (e) {
      emit(FinancialSummaryError(e.toString()));
    }
  }
}
