import '../../domain/entities/all_change_orders_data.dart';

abstract class AllChangeOrdersState {}

class AllChangeOrdersInitial extends AllChangeOrdersState {}

class AllChangeOrdersLoading extends AllChangeOrdersState {}

class AllChangeOrdersLoaded extends AllChangeOrdersState {
  final AllChangeOrdersData data;

  AllChangeOrdersLoaded(this.data);
}

class AllChangeOrdersEmpty extends AllChangeOrdersState {}

class AllChangeOrdersError extends AllChangeOrdersState {
  final String message;

  AllChangeOrdersError(this.message);
}
