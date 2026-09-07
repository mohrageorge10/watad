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
import 'package:watad/core/services/social_auth_service.dart';
import 'package:watad/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:watad/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:watad/features/auth/domain/repositories/auth_repository.dart';
import 'package:watad/features/auth/domain/usecases/auth_usecases.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //! Core / External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  sl.registerLazySingleton<SocialAuthService>(() => SocialAuthService());

  //! Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  //! Cache & Storage
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
  sl.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper());

  //! Owner Features
  initHomeFeature(sl);
  initFeasibilityFeature(sl);
  initCreateProjectFeature(sl);

  //! Auth Feature
  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiConsumer: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmEmailUseCase(sl()));
  sl.registerLazySingleton(() => ResendOtpUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => GoogleLoginUseCase(sl()));
  sl.registerLazySingleton(() => FacebookLoginUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl(),
      registerUseCase: sl(),
      confirmEmailUseCase: sl(),
      resendOtpUseCase: sl(),
      forgotPasswordUseCase: sl(),
      verifyOtpUseCase: sl(),
      resetPasswordUseCase: sl(),
      googleLoginUseCase: sl(),
      facebookLoginUseCase: sl(),
      cacheHelper: sl(),
      secureStorage: sl(),
    ),
  );
}
