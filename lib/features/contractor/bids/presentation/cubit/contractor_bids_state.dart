import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_bid_entity.dart';

abstract class ContractorBidsState extends Equatable {
  const ContractorBidsState();

  @override
  List<Object?> get props => [];
}

class ContractorBidsInitial extends ContractorBidsState {}

class ContractorBidsLoading extends ContractorBidsState {}

class ContractorBidsSuccess extends ContractorBidsState {
  final List<ContractorBidEntity> bids;
  final bool hasMore;
  final bool isLoadingMore;

  const ContractorBidsSuccess({
    required this.bids,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [bids, hasMore, isLoadingMore];
}

class ContractorBidsEmpty extends ContractorBidsState {}

class ContractorBidsError extends ContractorBidsState {
  final String message;

  const ContractorBidsError(this.message);

  @override
  List<Object?> get props => [message];
}
