import 'package:get_it/get_it.dart';
import 'package:watad/features/contractor/project_dashboard/data/datasources/contractor_project_dashboard_remote_data_source.dart';
import 'package:watad/features/contractor/project_dashboard/data/repositories/contractor_project_dashboard_repository_impl.dart';
import 'package:watad/features/contractor/project_dashboard/domain/repositories/contractor_project_dashboard_repository.dart';
import 'package:watad/features/contractor/project_dashboard/domain/usecases/get_contractor_project_dashboard_usecase.dart';
import 'package:watad/features/contractor/project_dashboard/presentation/cubit/contractor_project_dashboard_cubit.dart';

void initContractorProjectDashboardFeature(GetIt sl) {
  sl.registerLazySingleton<ContractorProjectDashboardRemoteDataSource>(
    () => ContractorProjectDashboardRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  sl.registerLazySingleton<ContractorProjectDashboardRepository>(
    () => ContractorProjectDashboardRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(
    () => GetContractorProjectDashboardUseCase(sl()),
  );

  sl.registerFactory(
    () => ContractorProjectDashboardCubit(
      getProjectDashboardUseCase: sl(),
    ),
  );
}
