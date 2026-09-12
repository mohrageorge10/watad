import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/utils/cache_keys.dart';
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
        final cachedImage = cacheHelper.getData(key: 'contractor_cached_profile_image') as String?;
        final cachedName = cacheHelper.getData(key: 'contractor_cached_name') as String?;

        final updatedData = data.copyWith(
          userImage: cachedImage ?? data.userImage,
          userName: (cachedName != null && cachedName.isNotEmpty) ? cachedName : data.userName,
        );

        if (updatedData.isEmptyState) {
          emit(ContractorHomeEmpty(updatedData));
        } else {
          emit(ContractorHomeSuccess(updatedData));
        }
      },
      (failure) {
        emit(ContractorHomeError(failure.errMessage));
      },
    );
  }
}
