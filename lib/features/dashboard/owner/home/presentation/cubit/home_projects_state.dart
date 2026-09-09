import 'package:equatable/equatable.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/project_summary.dart';

enum HomeProjectsStatus { initial, loading, loadingMore, success, empty, failure }

class HomeProjectsState extends Equatable {
  final HomeProjectsStatus status;
  final List<ProjectSummary> items;
  final int currentPage;
  final bool hasNext;
  final String? errorMessage;

  const HomeProjectsState({
    required this.status,
    required this.items,
    required this.currentPage,
    required this.hasNext,
    this.errorMessage,
  });

  factory HomeProjectsState.initial() => const HomeProjectsState(
        status: HomeProjectsStatus.initial,
        items: [],
        currentPage: 0,
        hasNext: false,
      );

  HomeProjectsState copyWith({
    HomeProjectsStatus? status,
    List<ProjectSummary>? items,
    int? currentPage,
    bool? hasNext,
    String? errorMessage,
  }) {
    return HomeProjectsState(
      status: status ?? this.status,
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasNext: hasNext ?? this.hasNext,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, currentPage, hasNext, errorMessage];
}
