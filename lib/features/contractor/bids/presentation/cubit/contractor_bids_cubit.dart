import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/contractor/bids/domain/usecases/get_contractor_bids_usecase.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/contractor_bids_state.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_bid_entity.dart';

class ContractorBidsCubit extends Cubit<ContractorBidsState> {
  final GetContractorBidsUseCase getContractorBidsUseCase;

  int _currentPage = 1;
  static const int _pageSize = 10;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  final List<ContractorBidEntity> _bids = [];

  ContractorBidsCubit({required this.getContractorBidsUseCase})
      : super(ContractorBidsInitial());

  List<ContractorBidEntity> get currentBids => List.unmodifiable(_bids);
  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  /// Loads the first page and resets pagination state
  Future<void> loadFirstPage() async {
    _currentPage = 1;
    _hasMore = true;
    _isLoadingMore = false;
    _bids.clear();
    emit(ContractorBidsLoading());

    final result = await getContractorBidsUseCase(
      pageNumber: _currentPage,
      pageSize: _pageSize,
    );

    result.fold(
      (newBids) {
        if (newBids.isEmpty) {
          emit(ContractorBidsEmpty());
        } else {
          _bids.addAll(newBids);
          _hasMore = newBids.length >= _pageSize;
          emit(ContractorBidsSuccess(
            bids: List.from(_bids),
            hasMore: _hasMore,
            isLoadingMore: false,
          ));
        }
      },
      (failure) {
        emit(ContractorBidsError(failure.errMessage));
      },
    );
  }

  /// Loads the next page for infinite scroll without clearing existing items
  Future<void> loadNextPage() async {
    if (!_hasMore || _isLoadingMore || state is! ContractorBidsSuccess) return;

    _isLoadingMore = true;
    emit(ContractorBidsSuccess(
      bids: List.from(_bids),
      hasMore: _hasMore,
      isLoadingMore: true,
    ));

    final nextPage = _currentPage + 1;
    final result = await getContractorBidsUseCase(
      pageNumber: nextPage,
      pageSize: _pageSize,
    );

    result.fold(
      (newBids) {
        _currentPage = nextPage;
        _isLoadingMore = false;
        if (newBids.isEmpty) {
          _hasMore = false;
        } else {
          _bids.addAll(newBids);
          _hasMore = newBids.length >= _pageSize;
        }
        emit(ContractorBidsSuccess(
          bids: List.from(_bids),
          hasMore: _hasMore,
          isLoadingMore: false,
        ));
      },
      (failure) {
        _isLoadingMore = false;
        // Retain existing items on pagination error
        emit(ContractorBidsSuccess(
          bids: List.from(_bids),
          hasMore: _hasMore,
          isLoadingMore: false,
        ));
      },
    );
  }

  /// Pull-to-refresh helper
  Future<void> refresh() async => await loadFirstPage();
}
