import 'package:get_it/get_it.dart';
import 'package:watad/features/contractor/marketplace/data/datasources/marketplace_remote_data_source.dart';
import 'package:watad/features/contractor/marketplace/data/repositories/marketplace_repository_impl.dart';
import 'package:watad/features/contractor/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:watad/features/contractor/marketplace/domain/usecases/get_marketplace_project_details_usecase.dart';
import 'package:watad/features/contractor/marketplace/domain/usecases/get_marketplace_projects_usecase.dart';
import 'package:watad/features/contractor/marketplace/presentation/cubit/marketplace_cubit.dart';

void initContractorMarketplaceFeature(GetIt sl) {
  //! DataSource
  sl.registerLazySingleton<MarketplaceRemoteDataSource>(
    () => MarketplaceRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  //! Repository
  sl.registerLazySingleton<MarketplaceRepository>(
    () => MarketplaceRepositoryImpl(remoteDataSource: sl()),
  );

  //! UseCases
  sl.registerLazySingleton(() => GetMarketplaceProjectsUseCase(sl()));
  sl.registerLazySingleton(() => GetMarketplaceProjectDetailsUseCase(sl()));

  //! Cubit
  sl.registerFactory(
    () => MarketplaceCubit(getMarketplaceProjectsUseCase: sl()),
  );
}
