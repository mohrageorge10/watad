abstract class CreateChangeOrderState {}

class CreateChangeOrderInitial extends CreateChangeOrderState {}

class CreateChangeOrderLoading extends CreateChangeOrderState {}

class CreateChangeOrderSuccess extends CreateChangeOrderState {
  final String orderId;

  CreateChangeOrderSuccess(this.orderId);
}

class CreateChangeOrderError extends CreateChangeOrderState {
  final String message;

  CreateChangeOrderError(this.message);
}
