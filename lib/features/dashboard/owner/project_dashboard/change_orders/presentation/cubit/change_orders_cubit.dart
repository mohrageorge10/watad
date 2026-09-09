import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/mock_change_orders_repository.dart';
import 'change_orders_state.dart';

class ChangeOrdersCubit extends Cubit<ChangeOrdersState> {
  final MockChangeOrdersRepository repository;

  ChangeOrdersCubit(this.repository) : super(ChangeOrdersInitial());

  Future<void> fetchChangeOrders() async {
    emit(ChangeOrdersLoading());
    try {
      final data = await repository.getChangeOrders();
      emit(ChangeOrdersLoaded(data));
    } catch (e) {
      emit(ChangeOrdersError(e.toString()));
    }
  }
}
