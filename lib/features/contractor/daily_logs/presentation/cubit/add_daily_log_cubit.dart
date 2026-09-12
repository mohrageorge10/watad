import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/contractor/daily_logs/domain/entities/daily_log_submission_entity.dart';
import 'package:watad/features/contractor/daily_logs/domain/usecases/submit_daily_log_usecase.dart';
import 'package:watad/features/contractor/daily_logs/presentation/cubit/add_daily_log_state.dart';

class AddDailyLogCubit extends Cubit<AddDailyLogState> {
  final SubmitDailyLogUseCase submitDailyLogUseCase;

  AddDailyLogCubit({
    required this.submitDailyLogUseCase,
  }) : super(const AddDailyLogState());

  void addMedia(List<String> newPaths) {
    final updated = List<String>.from(state.mediaList)..addAll(newPaths);
    emit(state.copyWith(mediaList: updated));
  }

  void removeMedia(int index) {
    if (index >= 0 && index < state.mediaList.length) {
      final updated = List<String>.from(state.mediaList)..removeAt(index);
      emit(state.copyWith(mediaList: updated));
    }
  }

  Future<void> runAiScan() async {
    emit(state.copyWith(aiScanStatus: AiScanStatus.scanning));

    await Future.delayed(const Duration(milliseconds: 1200));

    emit(state.copyWith(
      aiScanStatus: AiScanStatus.scanned,
      aiScanResult: 'Crack Detected (92% Confidence) • Structural Crack on Wall Section B. Recommendation: Monitor and repair within 7 days.',
    ));
  }

  void setAiScanResult(String result) {
    emit(state.copyWith(
      aiScanStatus: AiScanStatus.scanned,
      aiScanResult: result,
    ));
  }

  Future<void> submitDailyLog({
    required String projectId,
    required String projectName,
    required String milestoneName,
    required String location,
    required String workSummary,
    required String equipmentUsed,
    required int workersCount,
  }) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    final submission = DailyLogSubmissionEntity(
      projectId: projectId,
      projectName: projectName,
      milestoneName: milestoneName,
      location: location,
      logDate: DateTime.now(),
      mediaPaths: state.mediaList,
      isAiScanned: state.aiScanStatus == AiScanStatus.scanned,
      aiScanResult: state.aiScanResult,
      workSummary: workSummary,
      equipmentUsed: equipmentUsed,
      workersCount: workersCount,
      locationCoords: '30.0444° N, 31.2357° E',
      timestamp: DateTime.now().toLocal().toString().split('.').first,
    );

    final result = await submitDailyLogUseCase(submission);

    result.fold(
      (success) {
        emit(state.copyWith(
          isSubmitting: false,
          isSubmitSuccess: true,
        ));
      },
      (failure) {
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: failure.errMessage,
        ));
      },
    );
  }
}
