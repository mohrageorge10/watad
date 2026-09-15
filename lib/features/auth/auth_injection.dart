import 'package:get_it/get_it.dart';
import 'package:watad/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:watad/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:watad/features/auth/domain/repositories/auth_repository.dart';
import 'package:watad/features/auth/domain/usecases/auth_usecases.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';

void initAuthFeature(GetIt sl) {
  //! DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiConsumer: sl()),
  );

  //! Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  //! UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmEmailUseCase(sl()));
  sl.registerLazySingleton(() => ResendOtpUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyCurrentPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmNewPasswordUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  //! Cubit
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl(),
      registerUseCase: sl(),
      confirmEmailUseCase: sl(),
      resendOtpUseCase: sl(),
      forgotPasswordUseCase: sl(),
      verifyOtpUseCase: sl(),
      resetPasswordUseCase: sl(),
      verifyCurrentPasswordUseCase: sl(),
      confirmNewPasswordUseCase: sl(),
      logoutUseCase: sl(),
      cacheHelper: sl(),
      secureStorage: sl(),
    ),
  );
}
