import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/alerts/domain/entities/paginated_notifications.dart';
import 'package:watad/features/dashboard/owner/alerts/domain/usecases/get_notifications_usecase.dart';
import 'alerts_state.dart';

class AlertsCubit extends Cubit<AlertsState> {
  final GetNotificationsUseCase getNotificationsUseCase;

  static const int _pageSize = 10;
  int _currentPage = 1;

  AlertsCubit(this.getNotificationsUseCase) : super(AlertsInitial());

  Future<void> fetchAlerts({
    String? category,
    String? type,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      _currentPage = 1;
    }

    if (_currentPage == 1) {
      emit(AlertsLoading());
    } else {
      if (state is AlertsLoaded) {
        emit((state as AlertsLoaded).copyWith(isFetchingMore: true));
      }
    }

    final result = await getNotificationsUseCase(
      pageNumber: _currentPage,
      pageSize: _pageSize,
      category: category,
      type: type,
    );

    result.fold(
      (data) {
        if (_currentPage == 1) {
          emit(AlertsLoaded(
            data: data,
            activeCategory: category,
            activeType: type,
          ));
        } else {
          if (state is AlertsLoaded) {
            final currentState = state as AlertsLoaded;
            final updatedItems = [...currentState.data.items, ...data.items];
            final updatedData = PaginatedNotifications(
              items: updatedItems,
              currentPage: data.currentPage,
              totalPages: data.totalPages,
              pageSize: data.pageSize,
              totalCount: data.totalCount,
              hasPrevious: data.hasPrevious,
              hasNext: data.hasNext,
            );
            emit(currentState.copyWith(
              data: updatedData,
              isFetchingMore: false,
            ));
          }
        }
      },
      (failure) {
        emit(AlertsError(
          message: failure.errMessage,
          activeCategory: category,
          activeType: type,
        ));
      },
    );
  }

  void loadMore() {
    if (state is AlertsLoaded) {
      final currentState = state as AlertsLoaded;
      if (currentState.data.hasNext && !currentState.isFetchingMore) {
        _currentPage++;
        fetchAlerts(
          category: currentState.activeCategory,
          type: currentState.activeType,
          isRefresh: false,
        );
      }
    }
  }

  void filterCategory(String? category) {
    String? currentType;
    if (state is AlertsLoaded) {
      currentType = (state as AlertsLoaded).activeType;
    } else if (state is AlertsError) {
      currentType = (state as AlertsError).activeType;
    }
    
    fetchAlerts(
      category: category,
      type: currentType,
      isRefresh: true,
    );
  }

  void filterType(String? type) {
    String? currentCategory;
    if (state is AlertsLoaded) {
      currentCategory = (state as AlertsLoaded).activeCategory;
    } else if (state is AlertsError) {
      currentCategory = (state as AlertsError).activeCategory;
    }

    fetchAlerts(
      category: currentCategory,
      type: type,
      isRefresh: true,
    );
  }
}

