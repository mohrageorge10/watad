import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/project_dashboard/domain/entities/contractor_project_dashboard_entity.dart';

abstract class ContractorProjectDashboardState extends Equatable {
  const ContractorProjectDashboardState();

  @override
  List<Object?> get props => [];
}

class ContractorProjectDashboardInitial
    extends ContractorProjectDashboardState {}

class ContractorProjectDashboardLoading
    extends ContractorProjectDashboardState {}

class ContractorProjectDashboardSuccess
    extends ContractorProjectDashboardState {
  final ContractorProjectDashboardEntity dashboard;

  const ContractorProjectDashboardSuccess(this.dashboard);

  @override
  List<Object?> get props => [dashboard];
}

class ContractorProjectDashboardError extends ContractorProjectDashboardState {
  final String message;

  const ContractorProjectDashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
