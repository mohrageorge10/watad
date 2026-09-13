import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_change_order_details_usecase.dart';
import '../../domain/usecases/decide_change_order_usecase.dart';
import 'change_order_details_state.dart';

class ChangeOrderDetailsCubit extends Cubit<ChangeOrderDetailsState> {
  final GetChangeOrderDetailsUsecase getChangeOrderDetailsUsecase;
  final DecideChangeOrderUsecase decideChangeOrderUsecase;

  ChangeOrderDetailsCubit({
    required this.getChangeOrderDetailsUsecase,
    required this.decideChangeOrderUsecase,
  }) : super(ChangeOrderDetailsInitial());

  Future<void> getDetails(String id) async {
    emit(ChangeOrderDetailsLoading());
    final result = await getChangeOrderDetailsUsecase(id);
    result.fold(
      (data) => emit(ChangeOrderDetailsLoaded(data)),
      (error) => emit(ChangeOrderDetailsError(error.errMessage)),
    );
  }

  Future<void> acceptChangeOrder(String id) async {
    emit(ChangeOrderDecisionLoading());
    final result = await decideChangeOrderUsecase(id, true, null);
    result.fold(
      (_) => emit(ChangeOrderDecisionSuccess(true)),
      (error) => emit(ChangeOrderDecisionError(error.errMessage)),
    );
  }

  Future<void> rejectChangeOrder(String id, String reason) async {
    emit(ChangeOrderDecisionLoading());
    final result = await decideChangeOrderUsecase(id, false, reason);
    result.fold(
      (_) => emit(ChangeOrderDecisionSuccess(false)),
      (error) => emit(ChangeOrderDecisionError(error.errMessage)),
    );
  }
}
