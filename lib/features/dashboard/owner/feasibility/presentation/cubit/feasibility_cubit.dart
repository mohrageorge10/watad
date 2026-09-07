import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/errors/failure.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_report.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_request.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/usecases/calculate_feasibility_usecase.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/usecases/save_feasibility_usecase.dart';

abstract class FeasibilityState {}

class FeasibilityInitial extends FeasibilityState {}

class FeasibilityLoading extends FeasibilityState {}

class FeasibilitySuccess extends FeasibilityState {
  final FeasibilityReport report;
  FeasibilitySuccess(this.report);
}

class FeasibilityError extends FeasibilityState {
  final Failure failure;
  FeasibilityError(this.failure);
}

class SaveReportLoading extends FeasibilityState {}

class SaveReportSuccess extends FeasibilityState {}

class SaveReportError extends FeasibilityState {
  final Failure failure;
  SaveReportError(this.failure);
}

class FeasibilityCubit extends Cubit<FeasibilityState> {
  final CalculateFeasibilityUseCase calculateFeasibilityUseCase;
  final SaveFeasibilityUseCase saveFeasibilityUseCase;

  FeasibilityCubit(this.calculateFeasibilityUseCase, this.saveFeasibilityUseCase) : super(FeasibilityInitial());

  Future<void> calculateFeasibility(FeasibilityRequest request) async {
    if (state is FeasibilityLoading) return;
    
    emit(FeasibilityLoading());
    final result = await calculateFeasibilityUseCase(request);
    
    result.fold(
      (data) => emit(FeasibilitySuccess(data)),
      (failure) => emit(FeasibilityError(failure)),
    );
  }

  Future<void> saveReport(String reportId, String newProjectTitle) async {
    if (state is SaveReportLoading) return;

    emit(SaveReportLoading());
    final result = await saveFeasibilityUseCase(reportId, newProjectTitle);

    result.fold(
      (_) => emit(SaveReportSuccess()),
      (failure) => emit(SaveReportError(failure)),
    );
  }
}
