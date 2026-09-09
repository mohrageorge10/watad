import '../../domain/entities/alert_item.dart';

abstract class AlertsState {}

class AlertsInitial extends AlertsState {}

class AlertsLoading extends AlertsState {}

class AlertsLoaded extends AlertsState {
  final AlertsData data;
  final String activeCategory; // "All", "Critical", "Warning", "Info"

  AlertsLoaded({
    required this.data,
    this.activeCategory = 'All',
  });
}

class AlertsError extends AlertsState {
  final String message;

  AlertsError({required this.message});
}
