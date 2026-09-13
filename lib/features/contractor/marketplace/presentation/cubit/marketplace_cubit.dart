import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/contractor/marketplace/domain/usecases/get_marketplace_projects_usecase.dart';
import 'package:watad/features/contractor/marketplace/presentation/cubit/marketplace_state.dart';

class MarketplaceCubit extends Cubit<MarketplaceState> {
  final GetMarketplaceProjectsUseCase getMarketplaceProjectsUseCase;

  String _currentCategory = 'All';
  String _currentQuery = '';
  int? _currentMinBudget;

  MarketplaceCubit({
    required this.getMarketplaceProjectsUseCase,
  }) : super(const MarketplaceInitial());

  String get currentCategory => _currentCategory;
  String get currentQuery => _currentQuery;
  int? get currentMinBudget => _currentMinBudget;

  Future<void> loadProjects({
    String? category,
    String? searchQuery,
    int? minBudget,
    bool clearBudget = false,
  }) async {
    _currentCategory = category ?? _currentCategory;
    _currentQuery = searchQuery ?? _currentQuery;
    if (clearBudget) {
      _currentMinBudget = null;
    } else if (minBudget != null) {
      _currentMinBudget = minBudget;
    }

    emit(MarketplaceLoading(
      activeChip: _currentCategory,
      minBudget: _currentMinBudget,
    ));

    final result = await getMarketplaceProjectsUseCase(
      category: _currentCategory,
      searchQuery: _currentQuery,
      minBudget: _currentMinBudget,
    );

    if (isClosed) return;

    result.fold(
      (projects) {
        if (isClosed) return;
        if (projects.isEmpty) {
          emit(MarketplaceEmpty(
            message: _currentQuery.isNotEmpty
                ? 'No projects match "$_currentQuery"'
                : (_currentMinBudget != null
                    ? 'No projects found starting from EGP ${_currentMinBudget!}'
                    : 'No projects available in this category'),
            activeChip: _currentCategory,
            minBudget: _currentMinBudget,
          ));
        } else {
          emit(MarketplaceSuccess(
            projects: projects,
            activeChip: _currentCategory,
            searchQuery: _currentQuery,
            minBudget: _currentMinBudget,
          ));
        }
      },
      (failure) {
        if (isClosed) return;
        emit(MarketplaceError(
          message: failure.errMessage,
          activeChip: _currentCategory,
          minBudget: _currentMinBudget,
        ));
      },
    );
  }

  void selectFilterChip(String chip) {
    if (chip == _currentCategory) return;
    _currentCategory = chip;
    loadProjects(category: chip, searchQuery: _currentQuery);
  }

  void setBudgetFilter(int? minBudget) {
    _currentMinBudget = minBudget;
    loadProjects(
      category: _currentCategory,
      searchQuery: _currentQuery,
      minBudget: minBudget,
      clearBudget: minBudget == null,
    );
  }

  void clearFilters() {
    _currentCategory = 'All';
    _currentQuery = '';
    _currentMinBudget = null;
    loadProjects(
      category: 'All',
      searchQuery: '',
      clearBudget: true,
    );
  }

  void searchProjects(String query) {
    _currentQuery = query;
    loadProjects(category: _currentCategory, searchQuery: query);
  }

  void toggleBookmark(String projectId) {
    if (state is MarketplaceSuccess) {
      final currentSuccess = state as MarketplaceSuccess;
      final updatedList = currentSuccess.projects.map((p) {
        if (p.id == projectId) {
          return p.copyWith(isBookmarked: !p.isBookmarked);
        }
        return p;
      }).toList();

      emit(currentSuccess.copyWith(projects: updatedList));
    }
  }
}
