import 'package:equatable/equatable.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/bid_details.dart';

enum ActionState { initial, loading, success, error }

class BidDetailsState extends Equatable {
  final bool isLoading;
  final BidDetails? bidDetails;
  final String errorMessage;
  
  final ActionState actionState;
  final bool isAccepted;
  final String actionErrorMessage;

  const BidDetailsState({
    this.isLoading = true,
    this.bidDetails,
    this.errorMessage = '',
    this.actionState = ActionState.initial,
    this.isAccepted = false,
    this.actionErrorMessage = '',
  });

  BidDetailsState copyWith({
    bool? isLoading,
    BidDetails? bidDetails,
    String? errorMessage,
    ActionState? actionState,
    bool? isAccepted,
    String? actionErrorMessage,
  }) {
    return BidDetailsState(
      isLoading: isLoading ?? this.isLoading,
      bidDetails: bidDetails ?? this.bidDetails,
      errorMessage: errorMessage ?? this.errorMessage,
      actionState: actionState ?? this.actionState,
      isAccepted: isAccepted ?? this.isAccepted,
      actionErrorMessage: actionErrorMessage ?? this.actionErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        bidDetails,
        errorMessage,
        actionState,
        isAccepted,
        actionErrorMessage,
      ];
}
