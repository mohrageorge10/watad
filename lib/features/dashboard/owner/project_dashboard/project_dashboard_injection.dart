import 'package:get_it/get_it.dart';
import 'data/datasources/project_dashboard_remote_data_source.dart';
import 'data/repositories/project_dashboard_repository_impl.dart';
import 'domain/repositories/project_dashboard_repository.dart';
import 'domain/usecases/get_project_dashboard_usecase.dart';
import 'presentation/cubit/project_dashboard_cubit.dart';

import 'financial_summary/data/datasources/financial_summary_remote_data_source.dart';
import 'financial_summary/data/repositories/financial_summary_repository_impl.dart';
import 'financial_summary/domain/repositories/financial_summary_repository.dart';
import 'financial_summary/domain/usecases/get_financial_summary_usecase.dart';
import 'financial_summary/presentation/cubit/financial_summary_cubit.dart';

import 'progress_site_updates/data/datasources/progress_site_updates_remote_data_source.dart';
import 'progress_site_updates/data/repositories/progress_site_updates_repository_impl.dart';
import 'progress_site_updates/domain/repositories/progress_site_updates_repository.dart';
import 'progress_site_updates/domain/usecases/get_progress_site_updates_usecase.dart';
import 'progress_site_updates/presentation/cubit/progress_site_updates_cubit.dart';

import 'change_orders/data/datasources/change_orders_remote_data_source.dart';
import 'change_orders/data/repositories/change_orders_repository_impl.dart';
import 'change_orders/domain/repositories/change_orders_repository.dart';
import 'change_orders/domain/usecases/get_change_orders_usecase.dart';
import 'change_orders/domain/usecases/get_change_order_details_usecase.dart';
import 'change_orders/domain/usecases/decide_change_order_usecase.dart';
import 'change_orders/domain/usecases/create_change_order_usecase.dart';
import 'change_orders/presentation/cubit/change_orders_cubit.dart';
import 'change_orders/presentation/cubit/create_change_order_cubit.dart';
import 'change_orders/presentation/cubit/change_order_details_cubit.dart';
import 'change_orders/data/datasources/all_change_orders_remote_data_source.dart';
import 'change_orders/data/repositories/all_change_orders_repository_impl.dart';
import 'change_orders/domain/repositories/all_change_orders_repository.dart';
import 'change_orders/domain/usecases/get_all_change_orders_usecase.dart';
import 'change_orders/presentation/cubit/all_change_orders_cubit.dart';

void initProjectDashboardFeature(GetIt sl) {
  // --- Timeline / Dashboard Overview ---
  sl.registerLazySingleton<ProjectDashboardRemoteDataSource>(
    () => ProjectDashboardRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<ProjectDashboardRepository>(
    () => ProjectDashboardRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetProjectDashboardUseCase(sl()));

  sl.registerFactory(
    () => ProjectDashboardCubit(
      getProjectDashboardUseCase: sl(),
      getCurrentProjectOverviewUseCase: sl(),
    ),
  );

  // --- Financial Summary ---
  sl.registerLazySingleton<FinancialSummaryRemoteDataSource>(
    () => FinancialSummaryRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<FinancialSummaryRepository>(
    () => FinancialSummaryRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetFinancialSummaryUseCase(sl()));

  sl.registerFactory(
    () => FinancialSummaryCubit(
      getFinancialSummaryUseCase: sl(),
      getCurrentProjectOverviewUseCase: sl(),
    ),
  );

  // --- Progress Site Updates ---
  sl.registerLazySingleton<ProgressSiteUpdatesRemoteDataSource>(
    () => ProgressSiteUpdatesRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<ProgressSiteUpdatesRepository>(
    () => ProgressSiteUpdatesRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetProgressSiteUpdatesUseCase(sl()));

  sl.registerFactory(
    () => ProgressSiteUpdatesCubit(
      getProgressSiteUpdatesUseCase: sl(),
      getCurrentProjectOverviewUseCase: sl(),
    ),
  );

  // --- Change Orders ---
  sl.registerLazySingleton<ChangeOrdersRemoteDataSource>(
    () => ChangeOrdersRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<ChangeOrdersRepository>(
    () => ChangeOrdersRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetChangeOrdersUseCase(sl()));
  sl.registerLazySingleton(() => GetChangeOrderDetailsUsecase(repository: sl()));
  sl.registerLazySingleton(() => DecideChangeOrderUsecase(repository: sl()));
  sl.registerLazySingleton(() => CreateChangeOrderUseCase(repository: sl()));

  sl.registerFactory(
    () => ChangeOrdersCubit(
      getChangeOrdersUseCase: sl(),
      getCurrentProjectOverviewUseCase: sl(),
    ),
  );
  
  sl.registerFactory(
    () => ChangeOrderDetailsCubit(
      getChangeOrderDetailsUsecase: sl(),
      decideChangeOrderUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => CreateChangeOrderCubit(
      createChangeOrderUseCase: sl(),
      getCurrentProjectOverviewUseCase: sl(),
    ),
  );
  // --- All Change Orders ---
  sl.registerLazySingleton<AllChangeOrdersRemoteDataSource>(
    () => AllChangeOrdersRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<AllChangeOrdersRepository>(
    () => AllChangeOrdersRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => GetAllChangeOrdersUseCase(sl()));

  sl.registerFactory(
    () => AllChangeOrdersCubit(
      getAllChangeOrdersUseCase: sl(),
      getCurrentProjectOverviewUseCase: sl(),
    ),
  );
}
