import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/dio_consumer.dart';
import 'package:watad/core/network/connection/network_info.dart';
import 'package:watad/core/services/social_auth_service.dart';
import 'package:watad/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:watad/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:watad/features/auth/domain/repositories/auth_repository.dart';
import 'package:watad/features/auth/domain/usecases/auth_usecases.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/contractor/home/data/datasources/contractor_home_remote_data_source.dart';
import 'package:watad/features/contractor/home/data/repositories/contractor_home_repository_impl.dart';
import 'package:watad/features/contractor/home/domain/repositories/contractor_home_repository.dart';
import 'package:watad/features/contractor/home/domain/usecases/get_contractor_home_data_usecase.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_home_cubit.dart';
import 'package:watad/features/contractor/profile/data/datasources/contractor_profile_remote_data_source.dart';
import 'package:watad/features/contractor/profile/data/repositories/contractor_profile_repository_impl.dart';
import 'package:watad/features/contractor/profile/domain/repositories/contractor_profile_repository.dart';
import 'package:watad/features/contractor/profile/domain/usecases/get_contractor_profile_usecase.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';

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

  //! Contractor Home Feature
  // DataSource
  sl.registerLazySingleton<ContractorHomeRemoteDataSource>(
    () => ContractorHomeRemoteDataSourceImpl(apiConsumer: sl()),
  );

  // Repository
  sl.registerLazySingleton<ContractorHomeRepository>(
    () => ContractorHomeRepositoryImpl(
      remoteDataSource: sl(),
      cacheHelper: sl(),
    ),
  );

  // UseCase
  sl.registerLazySingleton(() => GetContractorHomeDataUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => ContractorHomeCubit(
      getContractorHomeDataUseCase: sl(),
      cacheHelper: sl(),
    ),
  );

  //! Contractor Profile Feature
  // DataSource
  sl.registerLazySingleton<ContractorProfileRemoteDataSource>(
    () => ContractorProfileRemoteDataSourceImpl(apiConsumer: sl()),
  );

  // Repository
  sl.registerLazySingleton<ContractorProfileRepository>(
    () => ContractorProfileRepositoryImpl(
      remoteDataSource: sl(),
      cacheHelper: sl(),
    ),
  );

  // UseCase
  sl.registerLazySingleton(() => GetContractorProfileUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => ContractorProfileCubit(
      getContractorProfileUseCase: sl(),
      cacheHelper: sl(),
    ),
  );
}
