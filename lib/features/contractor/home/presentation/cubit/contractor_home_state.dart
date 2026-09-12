import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_home_entity.dart';

abstract class ContractorHomeState extends Equatable {
  const ContractorHomeState();

  @override
  List<Object?> get props => [];
}

class ContractorHomeInitial extends ContractorHomeState {}

class ContractorHomeLoading extends ContractorHomeState {}

class ContractorHomeSuccess extends ContractorHomeState {
  final ContractorHomeEntity homeData;

  const ContractorHomeSuccess(this.homeData);

  @override
  List<Object?> get props => [homeData];
}

class ContractorHomeEmpty extends ContractorHomeState {
  final ContractorHomeEntity homeData;

  const ContractorHomeEmpty(this.homeData);

  @override
  List<Object?> get props => [homeData];
}

class ContractorHomeError extends ContractorHomeState {
  final String message;

  const ContractorHomeError(this.message);

  @override
  List<Object?> get props => [message];
}
