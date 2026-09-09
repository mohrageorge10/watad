import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/mock_progress_site_updates_repository.dart';
import 'progress_site_updates_state.dart';

class ProgressSiteUpdatesCubit extends Cubit<ProgressSiteUpdatesState> {
  final MockProgressSiteUpdatesRepository repository;

  ProgressSiteUpdatesCubit(this.repository) : super(ProgressSiteUpdatesInitial());

  Future<void> fetchProgressSiteUpdates() async {
    emit(ProgressSiteUpdatesLoading());
    try {
      final data = await repository.getProgressSiteUpdates();
      emit(ProgressSiteUpdatesLoaded(data));
    } catch (e) {
      emit(ProgressSiteUpdatesError(e.toString()));
    }
  }
}
