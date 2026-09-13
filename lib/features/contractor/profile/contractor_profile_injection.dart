import 'package:get_it/get_it.dart';
import 'package:watad/features/contractor/profile/data/datasources/contractor_profile_remote_data_source.dart';
import 'package:watad/features/contractor/profile/data/repositories/contractor_profile_repository_impl.dart';
import 'package:watad/features/contractor/profile/domain/repositories/contractor_profile_repository.dart';
import 'package:watad/features/contractor/profile/domain/usecases/get_contractor_profile_usecase.dart';
import 'package:watad/features/contractor/profile/domain/usecases/get_contractor_reviews_usecase.dart';
import 'package:watad/features/contractor/profile/domain/usecases/update_contractor_profile_usecase.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';

void initContractorProfileFeature(GetIt sl) {
  //! DataSource
  sl.registerLazySingleton<ContractorProfileRemoteDataSource>(
    () => ContractorProfileRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  //! Repository
  sl.registerLazySingleton<ContractorProfileRepository>(
    () => ContractorProfileRepositoryImpl(
      remoteDataSource: sl(),
      cacheHelper: sl(),
    ),
  );

  //! UseCases
  sl.registerLazySingleton(() => GetContractorProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateContractorProfileUseCase(sl()));
  sl.registerLazySingleton(() => GetContractorReviewsUseCase(sl()));

  //! Cubit
  sl.registerFactory(
    () => ContractorProfileCubit(
      getContractorProfileUseCase: sl(),
      updateContractorProfileUseCase: sl(),
      getContractorReviewsUseCase: sl(),
      cacheHelper: sl(),
    ),
  );
}
