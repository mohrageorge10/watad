import 'package:get_it/get_it.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/data/datasources/create_project_remote_data_source.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/data/repositories/create_project_repository_impl.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/domain/repositories/create_project_repository.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/domain/usecases/create_project_usecase.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/presentation/cubit/create_project_cubit.dart';

void initCreateProjectFeature(GetIt sl) {
  // Cubit
  sl.registerFactory(() => CreateProjectCubit(sl()));

  // UseCases
  sl.registerLazySingleton(() => CreateProjectUseCase(sl()));

  // Repository
  sl.registerLazySingleton<CreateProjectRepository>(
    () => CreateProjectRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<CreateProjectRemoteDataSource>(
    () => CreateProjectRemoteDataSourceImpl(apiConsumer: sl()),
  );
}
