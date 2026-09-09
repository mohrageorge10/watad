import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/contracts/domain/entities/contract_entity.dart';

abstract class ContractState extends Equatable {
  const ContractState();

  @override
  List<Object?> get props => [];
}

class ContractInitial extends ContractState {
  const ContractInitial();
}

class ContractLoading extends ContractState {
  const ContractLoading();
}

class ContractLoaded extends ContractState {
  final ContractEntity contract;

  const ContractLoaded(this.contract);

  @override
  List<Object?> get props => [contract];
}

class ContractSigning extends ContractState {
  final ContractEntity contract;

  const ContractSigning(this.contract);

  @override
  List<Object?> get props => [contract];
}

class ContractSignedSuccess extends ContractState {
  final ContractEntity contract;
  final String message;

  const ContractSignedSuccess({
    required this.contract,
    this.message = 'Contract has been signed successfully!',
  });

  @override
  List<Object?> get props => [contract, message];
}

class ContractError extends ContractState {
  final String message;

  const ContractError(this.message);

  @override
  List<Object?> get props => [message];
}
