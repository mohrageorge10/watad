import 'package:equatable/equatable.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_project_entity.dart';

abstract class ContractorMyProjectsState extends Equatable {
  const ContractorMyProjectsState();

  @override
  List<Object?> get props => [];
}

class ContractorMyProjectsInitial extends ContractorMyProjectsState {}

class ContractorMyProjectsLoading extends ContractorMyProjectsState {}

class ContractorMyProjectsSuccess extends ContractorMyProjectsState {
  final List<ContractorProjectEntity> projects;
  final List<ContractorProjectEntity> filteredProjects;
  final String searchQuery;

  const ContractorMyProjectsSuccess({
    required this.projects,
    required this.filteredProjects,
    this.searchQuery = '',
  });

  ContractorMyProjectsSuccess copyWith({
    List<ContractorProjectEntity>? projects,
    List<ContractorProjectEntity>? filteredProjects,
    String? searchQuery,
  }) {
    return ContractorMyProjectsSuccess(
      projects: projects ?? this.projects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [projects, filteredProjects, searchQuery];
}

class ContractorMyProjectsEmpty extends ContractorMyProjectsState {
  final String message;

  const ContractorMyProjectsEmpty({
    this.message = 'You do not have any active contracted projects in progress yet.',
  });

  @override
  List<Object?> get props => [message];
}

class ContractorMyProjectsError extends ContractorMyProjectsState {
  final String message;

  const ContractorMyProjectsError(this.message);

  @override
  List<Object?> get props => [message];
}
