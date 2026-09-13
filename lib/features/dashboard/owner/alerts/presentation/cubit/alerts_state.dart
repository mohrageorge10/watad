import 'package:watad/features/dashboard/owner/alerts/domain/entities/paginated_notifications.dart';

abstract class AlertsState {}

class AlertsInitial extends AlertsState {}

class AlertsLoading extends AlertsState {}

class AlertsLoaded extends AlertsState {
  final PaginatedNotifications data;
  final String? activeCategory;
  final String? activeType;
  final bool isFetchingMore;

  AlertsLoaded({
    required this.data,
    this.activeCategory,
    this.activeType,
    this.isFetchingMore = false,
  });

  AlertsLoaded copyWith({
    PaginatedNotifications? data,
    String? activeCategory,
    String? activeType,
    bool? isFetchingMore,
  }) {
    return AlertsLoaded(
      data: data ?? this.data,
      activeCategory: activeCategory ?? this.activeCategory,
      activeType: activeType ?? this.activeType,
      isFetchingMore: isFetchingMore ?? this.isFetchingMore,
    );
  }
}

class AlertsError extends AlertsState {
  final String message;
  final String? activeCategory;
  final String? activeType;

  AlertsError({
    required this.message,
    this.activeCategory,
    this.activeType,
  });
}
