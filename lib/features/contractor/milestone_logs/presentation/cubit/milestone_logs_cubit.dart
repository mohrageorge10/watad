import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';
import 'package:watad/features/contractor/milestone_logs/domain/usecases/get_milestone_logs_usecase.dart';
import 'package:watad/features/contractor/milestone_logs/domain/usecases/request_milestone_inspection_usecase.dart';
import 'package:watad/features/contractor/milestone_logs/presentation/cubit/milestone_logs_state.dart';

class MilestoneLogsCubit extends Cubit<MilestoneLogsState> {
  final GetMilestoneLogsUseCase getMilestoneLogsUseCase;
  final RequestMilestoneInspectionUseCase requestMilestoneInspectionUseCase;

  MilestoneLogsCubit({
    required this.getMilestoneLogsUseCase,
    required this.requestMilestoneInspectionUseCase,
  }) : super(MilestoneLogsInitial());

  Future<void> loadMilestoneLogs(String projectId) async {
    emit(MilestoneLogsLoading());

    final headerResult = await getMilestoneLogsUseCase.getHeader(projectId);
    final logsResult = await getMilestoneLogsUseCase(projectId: projectId);

    headerResult.fold(
      (header) {
        logsResult.fold(
          (logs) {
            emit(MilestoneLogsSuccess(
              header: header,
              allLogs: logs,
            ));
          },
          (failure) {
            emit(MilestoneLogsError(failure.errMessage));
          },
        );
      },
      (failure) {
        emit(MilestoneLogsError(failure.errMessage));
      },
    );
  }

  void setFilter(MilestoneLogType? type) {
    if (state is MilestoneLogsSuccess) {
      final current = state as MilestoneLogsSuccess;
      if (type == null) {
        // Explicitly clear filter to show All Logs
        emit(current.copyWith(clearFilter: true));
      } else if (current.selectedFilter == type) {
        // Tapping the same active filter toggles it off
        emit(current.copyWith(clearFilter: true));
      } else {
        // Set new filter
        emit(current.copyWith(selectedFilter: type));
      }
    }
  }

  Future<void> requestInspection({
    required String projectId,
    required String milestoneId,
  }) async {
    if (state is! MilestoneLogsSuccess) return;
    final current = state as MilestoneLogsSuccess;

    emit(current.copyWith(isRequestingInspection: true));

    final result = await requestMilestoneInspectionUseCase(
      projectId: projectId,
      milestoneId: milestoneId,
    );

    result.fold(
      (success) {
        emit(current.copyWith(
          isRequestingInspection: false,
          isInspectionRequestedSuccess: true,
          inspectionMessage: 'Milestone inspection requested successfully!',
        ));
      },
      (failure) {
        emit(current.copyWith(
          isRequestingInspection: false,
          inspectionMessage: failure.errMessage,
        ));
      },
    );
  }
}
