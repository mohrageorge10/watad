import 'package:equatable/equatable.dart';
import 'package:watad/features/dashboard/owner/home/domain/entities/current_project_overview.dart';

abstract class HomeOverviewState extends Equatable {
  const HomeOverviewState();
  @override
  List<Object?> get props => [];
}

class HomeOverviewInitial extends HomeOverviewState {
  const HomeOverviewInitial();
}

class HomeOverviewLoading extends HomeOverviewState {
  const HomeOverviewLoading();
}

class HomeOverviewLoaded extends HomeOverviewState {
  final CurrentProjectOverview data;
  const HomeOverviewLoaded(this.data);
  @override
  List<Object?> get props => [data];
}

class HomeOverviewEmpty extends HomeOverviewState {
  const HomeOverviewEmpty();
}

class HomeOverviewError extends HomeOverviewState {
  final String message;
  const HomeOverviewError(this.message);
  @override
  List<Object?> get props => [message];
}
