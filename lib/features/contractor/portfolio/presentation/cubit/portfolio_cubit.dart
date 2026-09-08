import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/get_portfolio_projects_usecase.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final GetPortfolioProjectsUseCase getPortfolioProjectsUseCase;
  final CacheHelper cacheHelper;

  PortfolioCubit({
    required this.getPortfolioProjectsUseCase,
    required this.cacheHelper,
  }) : super(PortfolioInitial());

  Future<void> loadProjects({String? contractorId}) async {
    emit(PortfolioLoading());

    final currentId = contractorId ??
        (cacheHelper.getData(key: CacheKeys.userId) as String?) ??
        'contractor_default';

    final result = await getPortfolioProjectsUseCase(contractorId: currentId);

    result.fold(
      (projects) {
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
}
