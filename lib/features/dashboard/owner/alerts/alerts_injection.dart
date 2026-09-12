import 'package:get_it/get_it.dart';
import 'package:watad/features/dashboard/owner/alerts/data/datasources/alerts_remote_data_source.dart';
import 'package:watad/features/dashboard/owner/alerts/data/repositories/alerts_repository_impl.dart';
import 'package:watad/features/dashboard/owner/alerts/domain/repositories/alerts_repository.dart';
import 'package:watad/features/dashboard/owner/alerts/domain/usecases/get_notifications_usecase.dart';
import 'package:watad/features/dashboard/owner/alerts/presentation/cubit/alerts_cubit.dart';

void initAlertsFeature(GetIt sl) {
  //! Data sources
  sl.registerLazySingleton<AlertsRemoteDataSource>(
    () => AlertsRemoteDataSourceImpl(apiConsumer: sl()),
  );

  //! Repository
  sl.registerLazySingleton<AlertsRepository>(
    () => AlertsRepositoryImpl(remoteDataSource: sl()),
  );

  //! UseCases
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));

  //! Cubits
  sl.registerFactory(() => AlertsCubit(sl()));
}
