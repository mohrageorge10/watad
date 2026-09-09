import '../../domain/entities/change_order_summary_data.dart';

abstract class ChangeOrdersState {}

class ChangeOrdersInitial extends ChangeOrdersState {}

class ChangeOrdersLoading extends ChangeOrdersState {}

class ChangeOrdersLoaded extends ChangeOrdersState {
  final ChangeOrderSummaryData data;

  ChangeOrdersLoaded(this.data);
}

class ChangeOrdersError extends ChangeOrdersState {
  final String message;

  ChangeOrdersError(this.message);
}
