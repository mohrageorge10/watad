import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/contractor/bids/data/mock/mock_my_bids_data.dart';
import 'package:watad/features/contractor/bids/data/models/my_bid_model.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/my_bids_state.dart';

class MyBidsCubit extends Cubit<MyBidsState> {
  MyBidsCubit() : super(const MyBidsInitial());

  List<MyBidModel> _allBids = [];
  String _currentFilter = 'All';

  Future<void> loadBids() async {
    emit(MyBidsLoading(activeFilter: _currentFilter));

    try {
      // Simulate network latency cleanly
      await Future.delayed(const Duration(milliseconds: 200));

      _allBids = MockMyBidsData.getMockBids();
      _emitSuccess();
    } catch (e) {
      emit(MyBidsError(
        message: 'Failed to load bids: ${e.toString()}',
        activeFilter: _currentFilter,
      ));
    }
  }

  void changeFilter(String filter) {
    _currentFilter = filter;
    _emitSuccess();
  }

  void toggleBookmark(String bidId) {
    final index = _allBids.indexWhere((b) => b.id == bidId);
    if (index != -1) {
      final current = _allBids[index];
      _allBids[index] = current.copyWith(isBookmarked: !current.isBookmarked);
      _emitSuccess();
    }
  }

  void withdrawBid(String bidId) {
    final index = _allBids.indexWhere((b) => b.id == bidId);
    if (index != -1) {
      final current = _allBids[index];
      _allBids[index] = current.copyWith(
        status: 'Rejected',
        statusColorHex: '#FF3B30',
        rejectionReason:
            'Not a suitable match for the current project requirements.',
      );
      _emitSuccess();
    }
  }

  void updateBid(
    String bidId, {
    required String yourBid,
    required String duration,
  }) {
    final index = _allBids.indexWhere((b) => b.id == bidId);
    if (index != -1) {
      final current = _allBids[index];
      final formattedBid =
          yourBid.startsWith('EGP') ? yourBid : 'EGP $yourBid';
      final formattedDuration = duration.toLowerCase().contains('month')
          ? duration
          : '$duration Months';

      _allBids[index] = current.copyWith(
        yourBid: formattedBid,
        duration: formattedDuration,
      );
      _emitSuccess();
    }
  }

  void _emitSuccess() {
    final allCount = _allBids.length;
    final pendingCount =
        _allBids.where((b) => b.status == 'Pending Review').length;
    final acceptedCount = _allBids.where((b) => b.status == 'Accepted').length;
    final rejectedCount = _allBids.where((b) => b.status == 'Rejected').length;

    List<MyBidEntity> filtered;
    if (_currentFilter == 'Pending Review') {
      filtered = _allBids.where((b) => b.status == 'Pending Review').toList();
    } else if (_currentFilter == 'Accepted') {
      filtered = _allBids.where((b) => b.status == 'Accepted').toList();
    } else if (_currentFilter == 'Rejected') {
      filtered = _allBids.where((b) => b.status == 'Rejected').toList();
    } else {
      filtered = List.from(_allBids);
    }

    emit(MyBidsSuccess(
      allBids: List.unmodifiable(_allBids),
      filteredBids: filtered,
      activeFilter: _currentFilter,
      allCount: allCount,
      pendingCount: pendingCount,
      acceptedCount: acceptedCount,
      rejectedCount: rejectedCount,
    ));
  }
}
