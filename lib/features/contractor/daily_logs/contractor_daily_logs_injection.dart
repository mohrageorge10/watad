import 'package:get_it/get_it.dart';
import 'package:watad/features/contractor/daily_logs/data/datasources/daily_logs_remote_data_source.dart';
import 'package:watad/features/contractor/daily_logs/data/repositories/daily_logs_repository_impl.dart';
import 'package:watad/features/contractor/daily_logs/domain/repositories/daily_logs_repository.dart';
import 'package:watad/features/contractor/daily_logs/domain/usecases/submit_daily_log_usecase.dart';
import 'package:watad/features/contractor/daily_logs/presentation/cubit/add_daily_log_cubit.dart';

void initContractorDailyLogsFeature(GetIt sl) {
  sl.registerLazySingleton<DailyLogsRemoteDataSource>(
    () => DailyLogsRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  sl.registerLazySingleton<DailyLogsRepository>(
    () => DailyLogsRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(
    () => SubmitDailyLogUseCase(sl()),
  );

  sl.registerFactory(
    () => AddDailyLogCubit(
      submitDailyLogUseCase: sl(),
    ),
  );
}
