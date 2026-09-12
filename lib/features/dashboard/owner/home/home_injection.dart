import 'package:get_it/get_it.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_overview_cubit.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_projects_cubit.dart';

import 'data/datasources/home_remote_data_source.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/get_current_project_overview_usecase.dart';
import 'domain/usecases/get_owner_projects_usecase.dart';
import 'domain/usecases/get_owner_profile_usecase.dart';
import 'package:watad/features/dashboard/owner/home/presentation/cubit/home_profile_cubit.dart';


//
// Future<void> setupServiceLocator() async {
//   sl.registerLazySingleton<Dio>(() => Dio());
//   ...
//   sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
// }
void initHomeFeature(GetIt sl) {
  //! Data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(apiConsumer: sl()),
  );

  //! Repository
  sl.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  //! UseCases
  sl.registerLazySingleton(() => GetCurrentProjectOverviewUseCase(sl()));
  sl.registerLazySingleton(() => GetOwnerProjectsUseCase(sl()));
  sl.registerLazySingleton(() => GetOwnerProfileUseCase(sl()));

  sl.registerFactory(() => HomeOverviewCubit(sl()));
  sl.registerFactory(() => HomeProjectsCubit(sl()));
  sl.registerFactory(() => HomeProfileCubit(sl()));
}
