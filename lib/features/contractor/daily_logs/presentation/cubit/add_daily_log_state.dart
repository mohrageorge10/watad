import 'package:equatable/equatable.dart';

enum AiScanStatus { initial, scanning, scanned, failed }

class AddDailyLogState extends Equatable {
  final List<String> mediaList;
  final bool isSubmitting;
  final bool isSubmitSuccess;
  final String? errorMessage;
  final AiScanStatus aiScanStatus;
  final String aiScanResult;
  final String workSummary;
  final String equipmentUsed;
  final int workersCount;

  const AddDailyLogState({
    this.mediaList = const [],
    this.isSubmitting = false,
    this.isSubmitSuccess = false,
    this.errorMessage,
    this.aiScanStatus = AiScanStatus.initial,
    this.aiScanResult = '',
    this.workSummary = '',
    this.equipmentUsed = '',
    this.workersCount = 0,
  });

  AddDailyLogState copyWith({
    List<String>? mediaList,
    bool? isSubmitting,
    bool? isSubmitSuccess,
    String? errorMessage,
    AiScanStatus? aiScanStatus,
    String? aiScanResult,
    String? workSummary,
    String? equipmentUsed,
    int? workersCount,
  }) {
    return AddDailyLogState(
      mediaList: mediaList ?? this.mediaList,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitSuccess: isSubmitSuccess ?? this.isSubmitSuccess,
      errorMessage: errorMessage,
      aiScanStatus: aiScanStatus ?? this.aiScanStatus,
      aiScanResult: aiScanResult ?? this.aiScanResult,
      workSummary: workSummary ?? this.workSummary,
      equipmentUsed: equipmentUsed ?? this.equipmentUsed,
      workersCount: workersCount ?? this.workersCount,
    );
  }

  @override
  List<Object?> get props => [
        mediaList,
        isSubmitting,
        isSubmitSuccess,
        errorMessage,
        aiScanStatus,
        aiScanResult,
        workSummary,
        equipmentUsed,
        workersCount,
      ];
}
