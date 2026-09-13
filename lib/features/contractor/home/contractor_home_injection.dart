import 'package:get_it/get_it.dart';
import 'package:watad/features/contractor/home/data/datasources/contractor_home_remote_data_source.dart';
import 'package:watad/features/contractor/home/data/datasources/contractor_projects_remote_data_source.dart';
import 'package:watad/features/contractor/home/data/repositories/contractor_home_repository_impl.dart';
import 'package:watad/features/contractor/home/data/repositories/contractor_projects_repository_impl.dart';
import 'package:watad/features/contractor/home/domain/repositories/contractor_home_repository.dart';
import 'package:watad/features/contractor/home/domain/repositories/contractor_projects_repository.dart';
import 'package:watad/features/contractor/home/domain/usecases/get_contractor_home_data_usecase.dart';
import 'package:watad/features/contractor/home/domain/usecases/get_contractor_projects_usecase.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_home_cubit.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_my_projects_cubit.dart';

void initContractorHomeFeature(GetIt sl) {
  //! Home Data Source & Repository
  sl.registerLazySingleton<ContractorHomeRemoteDataSource>(
    () => ContractorHomeRemoteDataSourceImpl(
      apiConsumer: sl(),
      projectsRemoteDataSource: sl(),
      bidsRemoteDataSource: sl(),
      profileRemoteDataSource: sl(),
      cacheHelper: sl(),
      secureStorage: sl(),
    ),
  );

  sl.registerLazySingleton<ContractorHomeRepository>(
    () => ContractorHomeRepositoryImpl(
      remoteDataSource: sl(),
      cacheHelper: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetContractorHomeDataUseCase(sl()));

  //! Projects Data Source & Repository
  sl.registerLazySingleton<ContractorProjectsRemoteDataSource>(
    () => ContractorProjectsRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  sl.registerLazySingleton<ContractorProjectsRepository>(
    () => ContractorProjectsRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetContractorProjectsUseCase(sl()));

  //! Cubits
  sl.registerFactory(
    () => ContractorHomeCubit(
      getContractorHomeDataUseCase: sl(),
      cacheHelper: sl(),
    ),
  );

  sl.registerFactory(
    () => ContractorMyProjectsCubit(
      getContractorProjectsUseCase: sl(),
    ),
  );
}
