import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/accept_bid_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/get_bid_details_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/reject_bid_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/bid_details_state.dart';

class BidDetailsCubit extends Cubit<BidDetailsState> {
  final GetBidDetailsUseCase getBidDetailsUseCase;
  final AcceptBidUseCase acceptBidUseCase;
  final RejectBidUseCase rejectBidUseCase;

  BidDetailsCubit({
    required this.getBidDetailsUseCase,
    required this.acceptBidUseCase,
    required this.rejectBidUseCase,
  }) : super(const BidDetailsState());

  Future<void> fetchBidDetails(String bidId) async {
    emit(state.copyWith(isLoading: true));
    final result = await getBidDetailsUseCase(bidId);
    
    result.fold(
      (data) {
        emit(state.copyWith(
          isLoading: false,
          bidDetails: data,
        ));
      },
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: failure.errMessage,
        ));
      },
    );
  }

  Future<void> acceptBid(String bidId) async {
    emit(state.copyWith(actionState: ActionState.loading));
    final result = await acceptBidUseCase(bidId);
    
    result.fold(
      (_) {
        emit(state.copyWith(
          actionState: ActionState.success,
          isAccepted: true,
        ));
      },
      (failure) {
        emit(state.copyWith(
          actionState: ActionState.error,
          actionErrorMessage: failure.errMessage,
        ));
      },
    );
  }

  Future<void> rejectBid(String bidId) async {
    emit(state.copyWith(actionState: ActionState.loading));
    final result = await rejectBidUseCase(bidId);
    
    result.fold(
      (_) {
        emit(state.copyWith(
          actionState: ActionState.success,
          isAccepted: false,
        ));
      },
      (failure) {
        emit(state.copyWith(
          actionState: ActionState.error,
          actionErrorMessage: failure.errMessage,
        ));
      },
    );
  }
}
