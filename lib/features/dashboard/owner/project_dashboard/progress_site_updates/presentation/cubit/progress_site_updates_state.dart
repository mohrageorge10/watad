import '../../domain/entities/progress_updates_data.dart';

abstract class ProgressSiteUpdatesState {}

class ProgressSiteUpdatesInitial extends ProgressSiteUpdatesState {}

class ProgressSiteUpdatesLoading extends ProgressSiteUpdatesState {}

class ProgressSiteUpdatesLoaded extends ProgressSiteUpdatesState {
  final ProgressUpdatesData data;

  ProgressSiteUpdatesLoaded(this.data);
}

class ProgressSiteUpdatesError extends ProgressSiteUpdatesState {
  final String message;

  ProgressSiteUpdatesError(this.message);
}
