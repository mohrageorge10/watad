import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/domain/entities/change_order_details.dart';

abstract class ChangeOrderDetailsState {}

class ChangeOrderDetailsInitial extends ChangeOrderDetailsState {}

class ChangeOrderDetailsLoading extends ChangeOrderDetailsState {}

class ChangeOrderDetailsLoaded extends ChangeOrderDetailsState {
  final ChangeOrderDetails details;
  ChangeOrderDetailsLoaded(this.details);
}

class ChangeOrderDetailsError extends ChangeOrderDetailsState {
  final String message;
  ChangeOrderDetailsError(this.message);
}

class ChangeOrderDecisionLoading extends ChangeOrderDetailsState {}

class ChangeOrderDecisionSuccess extends ChangeOrderDetailsState {
  final bool isApproved;
  ChangeOrderDecisionSuccess(this.isApproved);
}

class ChangeOrderDecisionError extends ChangeOrderDetailsState {
  final String message;
  ChangeOrderDecisionError(this.message);
}
