import 'package:equatable/equatable.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/contractor_profile.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/project_bid.dart';

enum RequestState { loading, loaded, empty, error }

class MarketplaceState extends Equatable {
  final RequestState contractorsState;
  final List<ContractorProfile> contractors;
  final String contractorsErrorMessage;

  final RequestState bidsState;
  final List<ProjectBid> bids;
  final String bidsErrorMessage;

  const MarketplaceState({
    this.contractorsState = RequestState.loading,
    this.contractors = const [],
    this.contractorsErrorMessage = '',
    this.bidsState = RequestState.loading,
    this.bids = const [],
    this.bidsErrorMessage = '',
  });

  MarketplaceState copyWith({
    RequestState? contractorsState,
    List<ContractorProfile>? contractors,
    String? contractorsErrorMessage,
    RequestState? bidsState,
    List<ProjectBid>? bids,
    String? bidsErrorMessage,
  }) {
    return MarketplaceState(
      contractorsState: contractorsState ?? this.contractorsState,
      contractors: contractors ?? this.contractors,
      contractorsErrorMessage: contractorsErrorMessage ?? this.contractorsErrorMessage,
      bidsState: bidsState ?? this.bidsState,
      bids: bids ?? this.bids,
      bidsErrorMessage: bidsErrorMessage ?? this.bidsErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        contractorsState,
        contractors,
        contractorsErrorMessage,
        bidsState,
        bids,
        bidsErrorMessage,
      ];
}
