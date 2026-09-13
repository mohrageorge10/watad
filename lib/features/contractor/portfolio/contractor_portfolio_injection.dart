import 'package:get_it/get_it.dart';
import 'package:watad/features/contractor/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:watad/features/contractor/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:watad/features/contractor/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/add_portfolio_project_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/delete_portfolio_project_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/get_portfolio_project_details_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/get_portfolio_projects_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/update_portfolio_project_usecase.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_cubit.dart';

void initContractorPortfolioFeature(GetIt sl) {
  //! DataSource
  sl.registerLazySingleton<PortfolioRemoteDataSource>(
    () => PortfolioRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  //! Repository
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(remoteDataSource: sl()),
  );

  //! UseCases
  sl.registerLazySingleton(() => GetPortfolioProjectsUseCase(sl()));
  sl.registerLazySingleton(() => AddPortfolioProjectUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePortfolioProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetPortfolioProjectDetailsUseCase(sl()));
  sl.registerLazySingleton(() => DeletePortfolioProjectUseCase(sl()));

  //! Cubit
  sl.registerFactory(
    () => PortfolioCubit(
      getPortfolioProjectsUseCase: sl(),
      addPortfolioProjectUseCase: sl(),
      updatePortfolioProjectUseCase: sl(),
      getPortfolioProjectDetailsUseCase: sl(),
      deletePortfolioProjectUseCase: sl(),
      cacheHelper: sl(),
    ),
  );
}
