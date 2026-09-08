import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/profile/domain/entities/contractor_profile_entity.dart';

abstract class ContractorProfileState extends Equatable {
  const ContractorProfileState();

  @override
  List<Object?> get props => [];
}

class ContractorProfileInitial extends ContractorProfileState {}

class ContractorProfileLoading extends ContractorProfileState {}

class ContractorProfileSuccess extends ContractorProfileState {
  final ContractorProfileEntity profile;
  final int selectedTabIndex;

  const ContractorProfileSuccess({
    required this.profile,
    this.selectedTabIndex = 0,
  });

  ContractorProfileSuccess copyWith({
    ContractorProfileEntity? profile,
    int? selectedTabIndex,
  }) {
    return ContractorProfileSuccess(
      profile: profile ?? this.profile,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object?> get props => [profile, selectedTabIndex];
}

class ContractorProfileEmpty extends ContractorProfileState {
  final String message;

  const ContractorProfileEmpty({
    this.message = 'No contractor profile data found.',
  });

  @override
  List<Object?> get props => [message];
}

class ContractorProfileError extends ContractorProfileState {
  final String message;

  const ContractorProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
