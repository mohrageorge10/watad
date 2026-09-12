import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/contractor/home/domain/entities/contractor_project_entity.dart';
import 'package:watad/features/contractor/home/domain/usecases/get_contractor_projects_usecase.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_my_projects_state.dart';

class ContractorMyProjectsCubit extends Cubit<ContractorMyProjectsState> {
  final GetContractorProjectsUseCase getContractorProjectsUseCase;

  List<ContractorProjectEntity> _allProjects = [];
  String _currentQuery = '';

  ContractorMyProjectsCubit({
    required this.getContractorProjectsUseCase,
  }) : super(ContractorMyProjectsInitial());

  List<ContractorProjectEntity> get allProjects => _allProjects;

  Future<void> loadProjects() async {
    emit(ContractorMyProjectsLoading());

    final result = await getContractorProjectsUseCase();

    result.fold(
      (projects) {
        // Filter strictly to In Progress / Accepted projects
        _allProjects = projects.where((p) {
          final text = p.badgeText.toLowerCase();
          return text.contains('progress') || text.contains('accepted') || text.contains('contracted');
        }).toList();

        if (_allProjects.isEmpty) {
          emit(const ContractorMyProjectsEmpty());
        } else {
          _filterAndEmit();
        }
      },
      (failure) {
        emit(ContractorMyProjectsError(failure.errMessage));
      },
    );
  }

  void searchProjects(String query) {
    _currentQuery = query.trim().toLowerCase();
    _filterAndEmit();
  }

  void _filterAndEmit() {
    if (_allProjects.isEmpty) {
      emit(const ContractorMyProjectsEmpty());
      return;
    }

    if (_currentQuery.isEmpty) {
      emit(ContractorMyProjectsSuccess(
        projects: _allProjects,
        filteredProjects: _allProjects,
        searchQuery: _currentQuery,
      ));
    } else {
      final filtered = _allProjects.where((p) {
        return p.title.toLowerCase().contains(_currentQuery) ||
            p.location.toLowerCase().contains(_currentQuery) ||
            p.ownerName.toLowerCase().contains(_currentQuery);
      }).toList();

      if (filtered.isEmpty) {
        emit(ContractorMyProjectsEmpty(
          message: 'No projects match "$_currentQuery"',
        ));
      } else {
        emit(ContractorMyProjectsSuccess(
          projects: _allProjects,
          filteredProjects: filtered,
          searchQuery: _currentQuery,
        ));
      }
    }
  }
}
