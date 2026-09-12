import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/add_portfolio_project_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/delete_portfolio_project_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/get_portfolio_project_details_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/get_portfolio_projects_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/update_portfolio_project_usecase.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final GetPortfolioProjectsUseCase getPortfolioProjectsUseCase;
  final AddPortfolioProjectUseCase? addPortfolioProjectUseCase;
  final UpdatePortfolioProjectUseCase? updatePortfolioProjectUseCase;
  final GetPortfolioProjectDetailsUseCase? getPortfolioProjectDetailsUseCase;
  final DeletePortfolioProjectUseCase? deletePortfolioProjectUseCase;
  final CacheHelper cacheHelper;

  List<PortfolioProjectItemModel> _cachedProjects = [];

  PortfolioCubit({
    required this.getPortfolioProjectsUseCase,
    this.addPortfolioProjectUseCase,
    this.updatePortfolioProjectUseCase,
    this.getPortfolioProjectDetailsUseCase,
    this.deletePortfolioProjectUseCase,
    required this.cacheHelper,
  }) : super(PortfolioInitial());

  List<PortfolioProjectItemModel> get cachedProjects => _cachedProjects;

  Future<void> loadProjects({String? contractorId}) async {
    emit(PortfolioLoading());

    final currentId = contractorId ??
        (cacheHelper.getData(key: CacheKeys.userId) as String?) ??
        'contractor_default';

    final result = await getPortfolioProjectsUseCase(contractorId: currentId);

    result.fold(
      (projects) {
        _cachedProjects = projects;
        if (projects.isEmpty) {
          emit(PortfolioEmpty());
        } else {
          emit(PortfolioSuccess(projects));
        }
      },
      (failure) {
        emit(PortfolioError(failure.errMessage));
      },
    );
  }

  Future<String?> addProject({
    required String title,
    required String description,
    required String location,
    required double projectCost,
    required String completionDate,
    required List<String> mediaUrls,
  }) async {
    emit(PortfolioActionLoading());

    final projectData = {
      'title': title,
      'description': description,
      'location': location,
      'projectCost': projectCost,
      'completionDate': completionDate,
      'mediaUrls': mediaUrls,
    };

    if (addPortfolioProjectUseCase != null) {
      final result = await addPortfolioProjectUseCase!(projectData: projectData);
      return result.fold(
        (project) {
          _cachedProjects = [project, ..._cachedProjects];
          emit(PortfolioActionSuccess('Project added successfully!', project: project));
          return null; // success, no error
        },
        (failure) {
          emit(PortfolioActionError(failure.errMessage));
          return failure.errMessage;
        },
      );
    }

    // Local fallback
    final newProj = PortfolioProjectItemModel(
      id: 'proj_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      description: description,
      location: location,
      price: 'EGP ${projectCost.toStringAsFixed(0)}',
      date: completionDate,
      image: mediaUrls.isNotEmpty ? mediaUrls.first : '',
      mediaUrls: mediaUrls,
      projectCost: projectCost,
      badgeText: 'Completed',
      badgeType: 'success',
    );
    _cachedProjects = [newProj, ..._cachedProjects];
    emit(PortfolioActionSuccess('Project added successfully!', project: newProj));
    return null;
  }

  Future<String?> updateProject({
    required String id,
    required String title,
    required String description,
    required String location,
    required double projectCost,
    required String completionDate,
    required List<String> mediaUrls,
  }) async {
    emit(PortfolioActionLoading());

    final projectData = {
      'title': title,
      'description': description,
      'location': location,
      'projectCost': projectCost,
      'completionDate': completionDate,
      'mediaUrls': mediaUrls,
    };

    if (updatePortfolioProjectUseCase != null) {
      final result = await updatePortfolioProjectUseCase!(
        projectId: id,
        projectData: projectData,
      );
      return result.fold(
        (updated) {
          _cachedProjects = _cachedProjects.map((p) => p.id == id ? updated : p).toList();
          emit(PortfolioActionSuccess('Project updated successfully!', project: updated));
          return null;
        },
        (failure) {
          emit(PortfolioActionError(failure.errMessage));
          return failure.errMessage;
        },
      );
    }

    final updated = PortfolioProjectItemModel(
      id: id,
      title: title,
      description: description,
      location: location,
      price: 'EGP ${projectCost.toStringAsFixed(0)}',
      date: completionDate,
      image: mediaUrls.isNotEmpty ? mediaUrls.first : '',
      mediaUrls: mediaUrls,
      projectCost: projectCost,
      badgeText: 'Completed',
      badgeType: 'success',
    );
    _cachedProjects = _cachedProjects.map((p) => p.id == id ? updated : p).toList();
    emit(PortfolioActionSuccess('Project updated successfully!', project: updated));
    return null;
  }

  Future<String?> deleteProject(String projectId) async {
    emit(PortfolioActionLoading());

    if (deletePortfolioProjectUseCase != null) {
      final result = await deletePortfolioProjectUseCase!(projectId: projectId);
      return result.fold(
        (_) {
          _cachedProjects = _cachedProjects.where((p) => p.id != projectId).toList();
          emit(const PortfolioActionSuccess('Project deleted successfully!'));
          return null;
        },
        (failure) {
          emit(PortfolioActionError(failure.errMessage));
          return failure.errMessage;
        },
      );
    }

    _cachedProjects = _cachedProjects.where((p) => p.id != projectId).toList();
    emit(const PortfolioActionSuccess('Project deleted successfully!'));
    return null;
  }

  Future<PortfolioProjectItemModel?> getProjectDetails(String projectId) async {
    if (getPortfolioProjectDetailsUseCase != null) {
      final result = await getPortfolioProjectDetailsUseCase!(projectId: projectId);
      return result.fold(
        (project) {
          emit(PortfolioProjectDetailsSuccess(project));
          return project;
        },
        (_) => null,
      );
    }

    final local = _cachedProjects.firstWhere(
      (p) => p.id == projectId,
      orElse: () => _cachedProjects.isNotEmpty
          ? _cachedProjects.first
          : const PortfolioProjectItemModel(
              id: '',
              title: '',
              location: '',
              price: '',
              date: '',
              image: '',
              badgeText: '',
              badgeType: '',
            ),
    );
    emit(PortfolioProjectDetailsSuccess(local));
    return local;
  }
}
