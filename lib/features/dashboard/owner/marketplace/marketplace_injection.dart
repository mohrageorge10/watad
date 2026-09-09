import 'package:get_it/get_it.dart';
import 'package:watad/features/dashboard/owner/marketplace/data/datasources/marketplace_remote_data_source.dart';
import 'package:watad/features/dashboard/owner/marketplace/data/repositories/marketplace_repository_impl.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/accept_bid_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/get_bid_details_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/get_project_bids_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/get_recommended_contractors_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/usecases/reject_bid_usecase.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/bid_details_cubit.dart';
import 'package:watad/features/dashboard/owner/marketplace/presentation/cubit/marketplace_cubit.dart';

void initMarketplaceFeature(GetIt sl) {
  // Data Source
  sl.registerLazySingleton<MarketplaceRemoteDataSource>(
    () => MarketplaceRemoteDataSourceImpl(apiConsumer: sl()),
  );

  // Repository
  sl.registerLazySingleton<MarketplaceRepository>(
    () => MarketplaceRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetRecommendedContractorsUseCase(sl()));
  sl.registerLazySingleton(() => GetProjectBidsUseCase(sl()));
  sl.registerLazySingleton(() => GetBidDetailsUseCase(sl()));
  sl.registerLazySingleton(() => AcceptBidUseCase(sl()));
  sl.registerLazySingleton(() => RejectBidUseCase(sl()));

  // Cubits
  sl.registerFactory(
    () => MarketplaceCubit(
      getCurrentProjectOverviewUseCase: sl(),
      getRecommendedContractorsUseCase: sl(),
      getProjectBidsUseCase: sl(),
    ),
  );
  
  sl.registerFactory(
    () => BidDetailsCubit(
      getBidDetailsUseCase: sl(),
      acceptBidUseCase: sl(),
      rejectBidUseCase: sl(),
    ),
  );
}
