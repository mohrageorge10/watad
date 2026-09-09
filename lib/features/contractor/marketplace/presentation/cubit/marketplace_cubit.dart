import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/contractor/marketplace/domain/usecases/get_marketplace_projects_usecase.dart';
import 'package:watad/features/contractor/marketplace/presentation/cubit/marketplace_state.dart';

class MarketplaceCubit extends Cubit<MarketplaceState> {
  final GetMarketplaceProjectsUseCase getMarketplaceProjectsUseCase;

  String _currentCategory = 'All';
  String _currentQuery = '';

  MarketplaceCubit({
    required this.getMarketplaceProjectsUseCase,
  }) : super(const MarketplaceInitial());

  String get currentCategory => _currentCategory;
  String get currentQuery => _currentQuery;

  Future<void> loadProjects({
    String? category,
    String? searchQuery,
  }) async {
    _currentCategory = category ?? _currentCategory;
    _currentQuery = searchQuery ?? _currentQuery;

    emit(MarketplaceLoading(activeChip: _currentCategory));

    final result = await getMarketplaceProjectsUseCase(
      category: _currentCategory,
      searchQuery: _currentQuery,
    );

    result.fold(
      (projects) {
        if (projects.isEmpty) {
          emit(MarketplaceEmpty(
            message: _currentQuery.isNotEmpty
                ? 'No projects match "$_currentQuery"'
                : 'No projects available in this category',
            activeChip: _currentCategory,
          ));
        } else {
          emit(MarketplaceSuccess(
            projects: projects,
            activeChip: _currentCategory,
            searchQuery: _currentQuery,
          ));
        }
      },
      (failure) {
        emit(MarketplaceError(
          message: failure.errMessage,
          activeChip: _currentCategory,
        ));
      },
    );
  }

  void selectFilterChip(String chip) {
    if (_currentCategory == chip) return;
    _currentCategory = chip;
    loadProjects(category: chip, searchQuery: _currentQuery);
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
