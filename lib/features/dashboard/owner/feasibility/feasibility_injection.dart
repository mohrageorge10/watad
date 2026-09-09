import 'package:get_it/get_it.dart';
import 'package:watad/features/dashboard/owner/feasibility/data/datasources/feasibility_remote_data_source.dart';
import 'package:watad/features/dashboard/owner/feasibility/data/repositories/feasibility_repository_impl.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/repositories/feasibility_repository.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/usecases/calculate_feasibility_usecase.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/usecases/save_feasibility_usecase.dart';
import 'package:watad/features/dashboard/owner/feasibility/presentation/cubit/feasibility_cubit.dart';

void initFeasibilityFeature(GetIt sl) {
  // Cubit
  sl.registerFactory(() => FeasibilityCubit(sl(), sl()));

  // UseCases
  sl.registerLazySingleton(() => CalculateFeasibilityUseCase(sl()));
  sl.registerLazySingleton(() => SaveFeasibilityUseCase(sl()));

  // Repository
  sl.registerLazySingleton<FeasibilityRepository>(
    () => FeasibilityRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<FeasibilityRemoteDataSource>(
    () => FeasibilityRemoteDataSourceImpl(apiConsumer: sl()),
  );
}
