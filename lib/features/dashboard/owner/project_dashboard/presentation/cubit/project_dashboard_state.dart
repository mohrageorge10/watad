import 'package:equatable/equatable.dart';
import '../../domain/entities/dashboard_data.dart';

abstract class ProjectDashboardState extends Equatable {
  const ProjectDashboardState();

  @override
  List<Object?> get props => [];
}

class ProjectDashboardInitial extends ProjectDashboardState {}

class ProjectDashboardLoading extends ProjectDashboardState {}

class ProjectDashboardLoaded extends ProjectDashboardState {
  final DashboardData data;

  const ProjectDashboardLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class ProjectDashboardError extends ProjectDashboardState {
  final String message;

  const ProjectDashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
