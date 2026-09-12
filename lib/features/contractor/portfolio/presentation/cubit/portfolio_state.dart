import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';

abstract class PortfolioState extends Equatable {
  const PortfolioState();

  @override
  List<Object?> get props => [];
}

class PortfolioInitial extends PortfolioState {}

class PortfolioLoading extends PortfolioState {}

class PortfolioSuccess extends PortfolioState {
  final List<PortfolioProjectItemModel> projects;

  const PortfolioSuccess(this.projects);

  @override
  List<Object?> get props => [projects];
}

class PortfolioEmpty extends PortfolioState {}

class PortfolioError extends PortfolioState {
  final String message;

  const PortfolioError(this.message);

  @override
  List<Object?> get props => [message];
}

class PortfolioActionLoading extends PortfolioState {}

class PortfolioActionSuccess extends PortfolioState {
  final String message;
  final PortfolioProjectItemModel? project;

  const PortfolioActionSuccess(this.message, {this.project});

  @override
  List<Object?> get props => [message, project];
}

class PortfolioActionError extends PortfolioState {
  final String message;

  const PortfolioActionError(this.message);

  @override
  List<Object?> get props => [message];
}

class PortfolioProjectDetailsSuccess extends PortfolioState {
  final PortfolioProjectItemModel project;

  const PortfolioProjectDetailsSuccess(this.project);

  @override
  List<Object?> get props => [project];
}
