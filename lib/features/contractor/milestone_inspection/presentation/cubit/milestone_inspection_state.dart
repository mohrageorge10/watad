import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/entities/milestone_inspection_details_entity.dart';

abstract class MilestoneInspectionState extends Equatable {
  const MilestoneInspectionState();

  @override
  List<Object?> get props => [];
}

class MilestoneInspectionInitial extends MilestoneInspectionState {}

class MilestoneInspectionLoading extends MilestoneInspectionState {}

class MilestoneInspectionSuccess extends MilestoneInspectionState {
  final MilestoneInspectionDetailsEntity details;
  final String notes;
  final bool isSubmitting;
  final bool isSubmitSuccess;
  final String? submitErrorMessage;

  const MilestoneInspectionSuccess({
    required this.details,
    this.notes = '',
    this.isSubmitting = false,
    this.isSubmitSuccess = false,
    this.submitErrorMessage,
  });

  MilestoneInspectionSuccess copyWith({
    MilestoneInspectionDetailsEntity? details,
    String? notes,
    bool? isSubmitting,
    bool? isSubmitSuccess,
    String? submitErrorMessage,
  }) {
    return MilestoneInspectionSuccess(
      details: details ?? this.details,
      notes: notes ?? this.notes,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSubmitSuccess: isSubmitSuccess ?? this.isSubmitSuccess,
      submitErrorMessage: submitErrorMessage ?? this.submitErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        details,
        notes,
        isSubmitting,
        isSubmitSuccess,
        submitErrorMessage,
      ];
}

class MilestoneInspectionError extends MilestoneInspectionState {
  final String message;

  const MilestoneInspectionError(this.message);

  @override
  List<Object?> get props => [message];
}
