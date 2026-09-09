import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/bids/domain/entities/my_bid_entity.dart';

abstract class MyBidsState extends Equatable {
  const MyBidsState();

  @override
  List<Object?> get props => [];
}

class MyBidsInitial extends MyBidsState {
  const MyBidsInitial();
}

class MyBidsLoading extends MyBidsState {
  final String activeFilter;

  const MyBidsLoading({this.activeFilter = 'All'});

  @override
  List<Object?> get props => [activeFilter];
}

class MyBidsSuccess extends MyBidsState {
  final List<MyBidEntity> allBids;
  final List<MyBidEntity> filteredBids;
  final String activeFilter;
  final int allCount;
  final int pendingCount;
  final int acceptedCount;
  final int rejectedCount;

  const MyBidsSuccess({
    required this.allBids,
    required this.filteredBids,
    required this.activeFilter,
    required this.allCount,
    required this.pendingCount,
    required this.acceptedCount,
    required this.rejectedCount,
  });

  MyBidsSuccess copyWith({
    List<MyBidEntity>? allBids,
    List<MyBidEntity>? filteredBids,
    String? activeFilter,
    int? allCount,
    int? pendingCount,
    int? acceptedCount,
    int? rejectedCount,
  }) {
    return MyBidsSuccess(
      allBids: allBids ?? this.allBids,
      filteredBids: filteredBids ?? this.filteredBids,
      activeFilter: activeFilter ?? this.activeFilter,
      allCount: allCount ?? this.allCount,
      pendingCount: pendingCount ?? this.pendingCount,
      acceptedCount: acceptedCount ?? this.acceptedCount,
      rejectedCount: rejectedCount ?? this.rejectedCount,
    );
  }

  @override
  List<Object?> get props => [
        allBids,
        filteredBids,
        activeFilter,
        allCount,
        pendingCount,
        acceptedCount,
        rejectedCount,
      ];
}

class MyBidsError extends MyBidsState {
  final String message;
  final String activeFilter;

  const MyBidsError({
    required this.message,
    this.activeFilter = 'All',
  });

  @override
  List<Object?> get props => [message, activeFilter];
}
