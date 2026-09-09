import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/mock_alerts_repository.dart';
import 'alerts_state.dart';

class AlertsCubit extends Cubit<AlertsState> {
  final MockAlertsRepository repository;

  AlertsCubit(this.repository) : super(AlertsInitial());

  Future<void> fetchAlerts() async {
    emit(AlertsLoading());
    try {
      final data = await repository.getAlerts();
      emit(AlertsLoaded(data: data, activeCategory: 'All'));
    } catch (e) {
      emit(AlertsError(message: e.toString()));
    }
  }

  void filterCategory(String category) {
    if (state is AlertsLoaded) {
      final currentState = state as AlertsLoaded;
      emit(AlertsLoaded(data: currentState.data, activeCategory: category));
    }
  }
}
