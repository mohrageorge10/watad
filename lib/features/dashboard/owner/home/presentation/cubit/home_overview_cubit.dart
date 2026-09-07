import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/features/dashboard/owner/home/domain/usecases/get_current_project_overview_usecase.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_overview_state.dart';


class HomeOverviewCubit extends Cubit<HomeOverviewState> {
  final GetCurrentProjectOverviewUseCase getCurrentProjectOverviewUseCase;

  HomeOverviewCubit(this.getCurrentProjectOverviewUseCase)
      : super(const HomeOverviewInitial());

  Future<void> fetchOverview() async {
    emit(const HomeOverviewLoading());
    final result = await getCurrentProjectOverviewUseCase();
    result.fold(
      (data) {
        if (!data.hasActiveProject) {
          emit(const HomeOverviewEmpty());
        } else {
          emit(HomeOverviewLoaded(data));
        }
      },
      (failure) => emit(HomeOverviewError(failure.errMessage)),
    );
  }
}
