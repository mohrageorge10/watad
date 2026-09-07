import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/dio_consumer.dart';
import 'package:watad/core/network/connection/network_info.dart';
import 'package:watad/features/dashboard/owner/home/home_injection.dart';
import 'package:watad/features/dashboard/owner/feasibility/feasibility_injection.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/create_project_injection.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //! Core / External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());

  //! Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  //! Cache & Storage
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
  sl.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper());
  initHomeFeature(sl);
  initFeasibilityFeature(sl);
  initCreateProjectFeature(sl);
}
