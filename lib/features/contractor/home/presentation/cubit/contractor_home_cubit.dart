import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/di/service_locator.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/home/data/models/contractor_bid_model.dart';
import 'package:watad/features/contractor/home/domain/usecases/get_contractor_home_data_usecase.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_home_state.dart';
import 'package:watad/features/contractor/marketplace/domain/usecases/get_marketplace_projects_usecase.dart';

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

    await result.fold(
      (data) async {
        final cachedImage = cacheHelper.getData(key: 'contractor_cached_profile_image') as String?;
        final cachedName = cacheHelper.getData(key: 'contractor_cached_name') as String?;

        var bids = data.recentBids;
        if (sl.isRegistered<GetMarketplaceProjectsUseCase>()) {
          final mpResult = await sl<GetMarketplaceProjectsUseCase>()();
          mpResult.fold(
            (projects) {
              final projectMap = {
                for (var p in projects) p.id: p,
                for (var p in projects) p.title.toLowerCase().trim(): p,
              };

              bids = bids.map((bid) {
                final p = projectMap[bid.id] ??
                    projectMap[bid.title.toLowerCase().trim()];
                if (p != null) {
                  return ContractorBidModel(
                    id: bid.id,
                    title: bid.title,
                    location: (bid.location.isEmpty ||
                            bid.location == 'Egypt' ||
                            bid.location == '-')
                        ? p.location
                        : bid.location,
                    amount: bid.amount,
                    image: (bid.image.isEmpty ||
                                bid.image.contains('unsplash')) &&
                            p.image.isNotEmpty
                        ? p.image
                        : bid.image,
                    badgeText: bid.badgeText,
                    badgeColorHex: bid.badgeColorHex,
                  );
                }
                return bid;
              }).toList();
            },
            (_) {},
          );
        }

        final updatedData = data.copyWith(
          userImage: cachedImage ?? data.userImage,
          userName: (cachedName != null && cachedName.isNotEmpty) ? cachedName : data.userName,
          recentBids: bids,
        );

        if (isClosed) return;
        if (updatedData.isEmptyState) {
          emit(ContractorHomeEmpty(updatedData));
        } else {
          emit(ContractorHomeSuccess(updatedData));
        }
      },
      (failure) {
        if (isClosed) return;
        emit(ContractorHomeError(failure.errMessage));
      },
    );
  }
}
