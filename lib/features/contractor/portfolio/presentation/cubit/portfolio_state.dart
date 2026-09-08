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
