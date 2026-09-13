import 'dart:convert';
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

  static const String _kCachedPortfolioProjects =
      'contractor_cached_portfolio_projects';

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

  List<PortfolioProjectItemModel> _loadLocalCachedProjects() {
    final raw = cacheHelper.getData(key: _kCachedPortfolioProjects) as String?;
    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          return decoded
              .map((e) => PortfolioProjectItemModel.fromJson(
                  Map<String, dynamic>.from(e)))
              .toList();
        }
      } catch (_) {}
    }
    return [];
  }

  Future<void> _saveLocalCachedProjects(
      List<PortfolioProjectItemModel> list) async {
    final mapped = list.map((e) => e.toJson()).toList();
    await cacheHelper.saveData(
      key: _kCachedPortfolioProjects,
      value: jsonEncode(mapped),
    );
  }

  Future<void> loadProjects({String? contractorId}) async {
    emit(PortfolioLoading());

    final currentId = contractorId ??
        (cacheHelper.getData(key: CacheKeys.userId) as String?) ??
        'contractor_default';

    final result = await getPortfolioProjectsUseCase(contractorId: currentId);

    if (isClosed) return;
    result.fold(
      (projects) {
        if (isClosed) return;
        final local = _loadLocalCachedProjects();
        final merged = [
          ...local,
          ...projects.where((p) => !local.any((lp) =>
              lp.id == p.id ||
              lp.title.toLowerCase().trim() == p.title.toLowerCase().trim())),
        ];
        _cachedProjects = merged;
        if (merged.isEmpty) {
          emit(PortfolioEmpty());
        } else {
          emit(PortfolioSuccess(merged));
        }
      },
      (failure) {
        if (isClosed) return;
        final local = _loadLocalCachedProjects();
        if (local.isNotEmpty) {
          _cachedProjects = local;
          emit(PortfolioSuccess(local));
        } else {
          emit(PortfolioError(failure.errMessage));
        }
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

    // Send only the exact field names the backend expects
    final projectData = {
      'title': title, // Backend DTO uses 'title' not 'projectTitle'
      'description': description,
      'location': location,
      'projectCost': projectCost,
      'completionDate': completionDate,
      'Photos': mediaUrls, // Backend expects 'Photos' (capital P) for image files
    };

    if (addPortfolioProjectUseCase == null) {
      if (!isClosed) emit(PortfolioActionError('Add use case not configured'));
      return 'Add use case not configured';
    }

    final result = await addPortfolioProjectUseCase!(projectData: projectData);

    return result.fold(
      (addedProject) async {
        // Success: save to local cache and emit success
        final local = _loadLocalCachedProjects();
        final updatedList = [
          addedProject,
          ...local.where((p) => p.id != addedProject.id),
        ];
        await _saveLocalCachedProjects(updatedList);

        _cachedProjects = [
          addedProject,
          ..._cachedProjects.where((p) => p.id != addedProject.id),
        ];

        if (!isClosed) {
          emit(PortfolioActionSuccess('Project added successfully!',
              project: addedProject));
        }
        return null;
      },
      (failure) {
        // Failure: report error to user — don't silently add to local cache
        if (!isClosed) emit(PortfolioActionError(failure.errMessage));
        return failure.errMessage;
      },
    );
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

    // Send only the exact field names the backend expects
    final projectData = {
      'title': title, // Backend DTO uses 'title' not 'projectTitle'
      'description': description,
      'location': location,
      'projectCost': projectCost,
      'completionDate': completionDate,
      'NewPhotos': mediaUrls, // For update, backend uses 'NewPhotos'
    };

    if (updatePortfolioProjectUseCase != null) {
      final result = await updatePortfolioProjectUseCase!(
        projectId: id,
        projectData: projectData,
      );
      return result.fold(
        (updated) async {
          _cachedProjects =
              _cachedProjects.map((p) => p.id == id ? updated : p).toList();
          final local = _loadLocalCachedProjects();
          final updatedLocal =
              local.map((p) => p.id == id ? updated : p).toList();
          await _saveLocalCachedProjects(updatedLocal);
          emit(PortfolioActionSuccess('Project updated successfully!',
              project: updated));
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
