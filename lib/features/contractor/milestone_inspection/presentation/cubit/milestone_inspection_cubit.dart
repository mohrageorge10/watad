import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/usecases/get_milestone_inspection_details_usecase.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/usecases/submit_milestone_inspection_request_usecase.dart';
import 'package:watad/features/contractor/milestone_inspection/presentation/cubit/milestone_inspection_state.dart';

class MilestoneInspectionCubit extends Cubit<MilestoneInspectionState> {
  final GetMilestoneInspectionDetailsUseCase getMilestoneInspectionDetailsUseCase;
  final SubmitMilestoneInspectionRequestUseCase submitMilestoneInspectionRequestUseCase;

  MilestoneInspectionCubit({
    required this.getMilestoneInspectionDetailsUseCase,
    required this.submitMilestoneInspectionRequestUseCase,
  }) : super(MilestoneInspectionInitial());

  Future<void> loadInspectionDetails(String milestoneId) async {
    emit(MilestoneInspectionLoading());

    final result = await getMilestoneInspectionDetailsUseCase(milestoneId: milestoneId);

    result.fold(
      (details) {
        emit(MilestoneInspectionSuccess(details: details));
      },
      (failure) {
        emit(MilestoneInspectionError(failure.errMessage));
      },
    );
  }

  void updateNotes(String notes) {
    if (state is MilestoneInspectionSuccess) {
      final current = state as MilestoneInspectionSuccess;
      emit(current.copyWith(notes: notes));
    }
  }

  Future<void> submitInspectionRequest(String milestoneId) async {
    if (state is! MilestoneInspectionSuccess) return;
    final current = state as MilestoneInspectionSuccess;

    emit(current.copyWith(isSubmitting: true, submitErrorMessage: null));

    final result = await submitMilestoneInspectionRequestUseCase(
      milestoneId: milestoneId,
      notes: current.notes.isNotEmpty ? current.notes : null,
    );

    result.fold(
      (success) {
        emit(current.copyWith(
          isSubmitting: false,
          isSubmitSuccess: true,
        ));
      },
      (failure) {
        emit(current.copyWith(
          isSubmitting: false,
          submitErrorMessage: failure.errMessage,
        ));
      },
    );
  }
}
