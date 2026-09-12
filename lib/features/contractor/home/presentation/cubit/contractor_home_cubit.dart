import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/home/data/mock/contractor_home_mock_data.dart';
import 'package:watad/features/contractor/home/domain/usecases/get_contractor_home_data_usecase.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_home_state.dart';

class ContractorHomeCubit extends Cubit<ContractorHomeState> {
  final GetContractorHomeDataUseCase getContractorHomeDataUseCase;
  final CacheHelper cacheHelper;

  ContractorHomeCubit({
    required this.getContractorHomeDataUseCase,
    required this.cacheHelper,
  }) : super(ContractorHomeInitial());

  Future<void> loadHomeData({String? contractorId}) async {
    emit(ContractorHomeLoading());

    final currentId = contractorId ??
        (cacheHelper.getData(key: CacheKeys.userId) as String?) ??
        'contractor_default';

    final result = await getContractorHomeDataUseCase(contractorId: currentId);

    result.fold(
      (data) {
        if (data.isEmptyState) {
          emit(ContractorHomeEmpty(data));
        } else {
          emit(ContractorHomeSuccess(data));
        }
      },
      (failure) {
        emit(ContractorHomeError(failure.errMessage));
      },
    );
  }

  /// Helper to toggle between empty and populated mock data
  void toggleMockEmptyState() {
    ContractorHomeMockData.forceEmptyState =
        !ContractorHomeMockData.forceEmptyState;
    loadHomeData();
  }
}
