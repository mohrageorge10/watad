import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/features/contractor/bids/data/models/my_bid_model.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';
import 'package:watad/features/contractor/bids/domain/usecases/cancel_bid_usecase.dart';
import 'package:watad/features/contractor/bids/domain/usecases/get_my_bids_usecase.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/my_bids_state.dart';
import 'package:watad/features/contractor/marketplace/domain/usecases/get_marketplace_projects_usecase.dart';

class MyBidsCubit extends Cubit<MyBidsState> {
  final GetMyBidsUseCase? getMyBidsUseCase;
  final CancelBidUseCase? cancelBidUseCase;

  MyBidsCubit({
    this.getMyBidsUseCase,
    this.cancelBidUseCase,
  }) : super(const MyBidsInitial());

  List<MyBidModel> _allBids = [];
  String _currentFilter = 'All';

  Future<void> loadBids() async {
    emit(MyBidsLoading(activeFilter: _currentFilter));

    try {
      if (getMyBidsUseCase != null) {
        final result = await getMyBidsUseCase!();
        await result.fold(
          (bids) async {
            _allBids = bids
                .map((e) => e is MyBidModel
                    ? e
                    : MyBidModel(
                        id: e.id,
                        projectId: e.projectId,
                        title: e.title,
                        location: e.location,
                        image: e.image,
                        status: e.status,
                        statusColorHex: e.statusColorHex,
                        isBookmarked: e.isBookmarked,
                        yourBid: e.yourBid,
                        duration: e.duration,
                        submittedDate: e.submittedDate,
                        rejectionReason: e.rejectionReason,
                        landArea: e.landArea,
                        floors: e.floors,
                        finishingLevel: e.finishingLevel,
                        description: e.description,
                        proposal: e.proposal,
                        attachmentUrl: e.attachmentUrl,
                        attachmentName: e.attachmentName,
                        startDate: e.startDate,
                        completionDate: e.completionDate,
                        images: e.images,
                      ))
                .toList();

            // Link bids with Marketplace projects to get full specs (land, scope, location, description)
            if (sl.isRegistered<GetMarketplaceProjectsUseCase>()) {
              final mpResult = await sl<GetMarketplaceProjectsUseCase>()();
              mpResult.fold(
                (projects) {
                  final projectMap = {
                    for (var p in projects) p.id: p,
                    for (var p in projects) p.title.toLowerCase().trim(): p,
                  };

                  _allBids = _allBids.map((bid) {
                    final p = projectMap[bid.projectId] ??
                        projectMap[bid.title.toLowerCase().trim()];
                    if (p != null) {
                      return bid.copyWith(
                        location: (bid.location.isEmpty ||
                                bid.location == 'Egypt' ||
                                bid.location == '-')
                            ? p.location
                            : bid.location,
                        image: (bid.image.isEmpty ||
                                    bid.image.contains('unsplash')) &&
                                p.image.isNotEmpty
                            ? p.image
                            : bid.image,
                        landArea: (bid.landArea == '-' || bid.landArea.isEmpty)
                            ? p.specs.land
                            : bid.landArea,
                        floors: (bid.floors == '-' || bid.floors.isEmpty)
                            ? p.specs.scope
                            : bid.floors,
                        description: (bid.description ==
                                    'No description provided.' ||
                                bid.description == '-' ||
                                bid.description.isEmpty)
                            ? 'Project in ${p.location} with budget of ${p.budgetValue}. Land: ${p.specs.land}, Scope: ${p.specs.scope}.'
                            : bid.description,
                        startDate: (bid.startDate == '-' || bid.startDate.isEmpty)
                            ? (p.timePosted.isNotEmpty ? p.timePosted : 'Immediate')
                            : bid.startDate,
                        completionDate:
                            (bid.completionDate == '-' || bid.completionDate.isEmpty)
                                ? 'TBD'
                                : bid.completionDate,
                        images: bid.images.isEmpty && p.image.isNotEmpty
                            ? [p.image]
                            : bid.images,
                      );
                    }
                    return bid;
                  }).toList();
                },
                (_) {},
              );
            }

            _emitSuccess();
          },
          (failure) {
            if (isClosed) return;
            emit(MyBidsError(
              message: failure.errMessage,
              activeFilter: _currentFilter,
            ));
          },
        );
      } else {
        _allBids = [];
        _emitSuccess();
      }
    } catch (e) {
      if (isClosed) return;
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

  void withdrawBid(String bidId) async {
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
    if (cancelBidUseCase != null) {
      await cancelBidUseCase!(bidId);
    }
  }

  void updateBid(
    String bidId, {
    required String yourBid,
    required String duration,
    String? proposal,
    String? attachmentUrl,
    String? attachmentName,
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
        proposal: proposal ?? current.proposal,
        attachmentUrl: attachmentUrl ?? current.attachmentUrl,
        attachmentName: attachmentName ?? current.attachmentName,
      );
      _emitSuccess();
    }
  }

  void _emitSuccess() {
    if (isClosed) return;

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
