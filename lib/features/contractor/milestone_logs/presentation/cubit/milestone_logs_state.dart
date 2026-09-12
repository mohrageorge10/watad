import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/milestone_logs/domain/entities/milestone_log_item_entity.dart';

abstract class MilestoneLogsState extends Equatable {
  const MilestoneLogsState();

  @override
  List<Object?> get props => [];
}

class MilestoneLogsInitial extends MilestoneLogsState {}

class MilestoneLogsLoading extends MilestoneLogsState {}

class MilestoneLogsSuccess extends MilestoneLogsState {
  final MilestoneLogsHeaderEntity header;
  final List<MilestoneLogItemEntity> allLogs;
  final MilestoneLogType? selectedFilter;
  final bool isRequestingInspection;
  final bool isInspectionRequestedSuccess;
  final String? inspectionMessage;

  const MilestoneLogsSuccess({
    required this.header,
    required this.allLogs,
    this.selectedFilter,
    this.isRequestingInspection = false,
    this.isInspectionRequestedSuccess = false,
    this.inspectionMessage,
  });

  List<MilestoneLogItemEntity> get filteredLogs {
    if (selectedFilter == null) return allLogs;
    return allLogs.where((l) => l.type == selectedFilter).toList();
  }

  int get dailyLogsCount =>
      allLogs.where((l) => l.type == MilestoneLogType.dailyLog).length;
  int get qaqcCount =>
      allLogs.where((l) => l.type == MilestoneLogType.qaQc).length;
  int get safetyCount =>
      allLogs.where((l) => l.type == MilestoneLogType.safety).length;

  MilestoneLogsSuccess copyWith({
    MilestoneLogsHeaderEntity? header,
    List<MilestoneLogItemEntity>? allLogs,
    MilestoneLogType? selectedFilter,
    bool clearFilter = false,
    bool? isRequestingInspection,
    bool? isInspectionRequestedSuccess,
    String? inspectionMessage,
  }) {
    return MilestoneLogsSuccess(
      header: header ?? this.header,
      allLogs: allLogs ?? this.allLogs,
      selectedFilter:
          clearFilter ? null : (selectedFilter ?? this.selectedFilter),
      isRequestingInspection:
          isRequestingInspection ?? this.isRequestingInspection,
      isInspectionRequestedSuccess:
          isInspectionRequestedSuccess ?? this.isInspectionRequestedSuccess,
      inspectionMessage: inspectionMessage ?? this.inspectionMessage,
    );
  }

  @override
  List<Object?> get props => [
        header,
        allLogs,
        selectedFilter,
        isRequestingInspection,
        isInspectionRequestedSuccess,
        inspectionMessage,
      ];
}

class MilestoneLogsError extends MilestoneLogsState {
  final String message;

  const MilestoneLogsError(this.message);

  @override
  List<Object?> get props => [message];
}
