import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/home/domain/usecases/get_owner_projects_usecase.dart';

import 'home_projects_state.dart';

class HomeProjectsCubit extends Cubit<HomeProjectsState> {
  final GetOwnerProjectsUseCase getOwnerProjectsUseCase;

  static const int pageSize = 5;

  HomeProjectsCubit(this.getOwnerProjectsUseCase) : super(HomeProjectsState.initial());

  Future<void> loadFirstPage({int? status}) async {
    emit(state.copyWith(status: HomeProjectsStatus.loading));
    final result = await getOwnerProjectsUseCase(
      status: status,
      pageNumber: 1,
      pageSize: pageSize,
    );
    result.fold(
      (data) {
        emit(state.copyWith(
          status: data.items.isEmpty ? HomeProjectsStatus.empty : HomeProjectsStatus.success,
          items: data.items,
          currentPage: data.currentPage,
          hasNext: data.hasNext,
        ));
      },
      (failure) => emit(state.copyWith(
        status: HomeProjectsStatus.failure,
        errorMessage: failure.errMessage,
      )),
    );
  }

  Future<void> loadNextPage({int? status}) async {
    if (!state.hasNext || state.status == HomeProjectsStatus.loadingMore) return;

    emit(state.copyWith(status: HomeProjectsStatus.loadingMore));
    final result = await getOwnerProjectsUseCase(
      status: status,
      pageNumber: state.currentPage + 1,
      pageSize: pageSize,
    );
    result.fold(
      (data) => emit(state.copyWith(
        status: HomeProjectsStatus.success,
        items: [...state.items, ...data.items],
        currentPage: data.currentPage,
        hasNext: data.hasNext,
      )),
      (failure) => emit(state.copyWith(
        status: HomeProjectsStatus.success,
        errorMessage: failure.errMessage,
      )),
    );
  }
}
