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
import 'package:watad/features/dashboard/owner/marketplace/marketplace_injection.dart';
import 'package:watad/features/dashboard/owner/contracts/contracts_injection.dart';
import 'package:watad/core/services/social_auth_service.dart';
import 'package:watad/core/services/file_download_service.dart';
import 'package:watad/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:watad/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:watad/features/auth/domain/repositories/auth_repository.dart';
import 'package:watad/features/auth/domain/usecases/auth_usecases.dart';
import 'package:watad/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:watad/features/contractor/home/data/datasources/contractor_home_remote_data_source.dart';
import 'package:watad/features/contractor/home/data/repositories/contractor_home_repository_impl.dart';
import 'package:watad/features/contractor/home/domain/repositories/contractor_home_repository.dart';
import 'package:watad/features/contractor/home/domain/usecases/get_contractor_home_data_usecase.dart';
import 'package:watad/features/contractor/home/data/datasources/contractor_projects_remote_data_source.dart';
import 'package:watad/features/contractor/home/data/repositories/contractor_projects_repository_impl.dart';
import 'package:watad/features/contractor/home/domain/repositories/contractor_projects_repository.dart';
import 'package:watad/features/contractor/home/domain/usecases/get_contractor_projects_usecase.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_home_cubit.dart';
import 'package:watad/features/contractor/profile/data/datasources/contractor_profile_remote_data_source.dart';
import 'package:watad/features/contractor/profile/data/repositories/contractor_profile_repository_impl.dart';
import 'package:watad/features/contractor/profile/domain/repositories/contractor_profile_repository.dart';
import 'package:watad/features/contractor/profile/domain/usecases/get_contractor_profile_usecase.dart';
import 'package:watad/features/contractor/profile/domain/usecases/get_contractor_reviews_usecase.dart';
import 'package:watad/features/contractor/profile/domain/usecases/update_contractor_profile_usecase.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';
import 'package:watad/features/contractor/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:watad/features/contractor/portfolio/data/repositories/portfolio_repository_impl.dart';
import 'package:watad/features/contractor/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/add_portfolio_project_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/delete_portfolio_project_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/get_portfolio_project_details_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/get_portfolio_projects_usecase.dart';
import 'package:watad/features/contractor/portfolio/domain/usecases/update_portfolio_project_usecase.dart';
import 'package:watad/features/contractor/portfolio/presentation/cubit/portfolio_cubit.dart';
import 'package:watad/features/contractor/bids/data/datasources/contractor_bids_remote_data_source.dart';
import 'package:watad/features/contractor/bids/data/repositories/contractor_bids_repository_impl.dart';
import 'package:watad/features/contractor/bids/domain/repositories/contractor_bids_repository.dart';
import 'package:watad/features/contractor/bids/domain/usecases/cancel_bid_usecase.dart';
import 'package:watad/features/contractor/bids/domain/usecases/get_bid_details_usecase.dart';
import 'package:watad/features/contractor/bids/domain/usecases/get_contractor_bids_usecase.dart';
import 'package:watad/features/contractor/bids/domain/usecases/get_my_bids_usecase.dart';
import 'package:watad/features/contractor/bids/domain/usecases/submit_bid_usecase.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/contractor_bids_cubit.dart';
import 'package:watad/features/contractor/bids/presentation/cubit/my_bids_cubit.dart';
import 'package:watad/features/contractor/contracts/data/datasources/contracts_remote_data_source.dart';
import 'package:watad/features/contractor/contracts/data/repositories/contracts_repository_impl.dart';
import 'package:watad/features/contractor/contracts/domain/repositories/contracts_repository.dart';
import 'package:watad/features/contractor/contracts/domain/usecases/get_accepted_bid_contract_usecase.dart';
import 'package:watad/features/contractor/contracts/domain/usecases/get_contract_details_usecase.dart';
import 'package:watad/features/contractor/contracts/domain/usecases/sign_contract_usecase.dart';
import 'package:watad/features/contractor/contracts/presentation/cubit/contract_cubit.dart';
import 'package:watad/features/contractor/marketplace/data/datasources/marketplace_remote_data_source.dart';
import 'package:watad/features/contractor/marketplace/data/repositories/marketplace_repository_impl.dart';
import 'package:watad/features/contractor/marketplace/domain/repositories/marketplace_repository.dart';
import 'package:watad/features/contractor/marketplace/domain/usecases/get_marketplace_project_details_usecase.dart';
import 'package:watad/features/contractor/marketplace/domain/usecases/get_marketplace_projects_usecase.dart';
import 'package:watad/features/contractor/marketplace/presentation/cubit/marketplace_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //! Core / External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  sl.registerLazySingleton<SocialAuthService>(() => SocialAuthService());
  sl.registerLazySingleton<FileDownloadService>(() => FileDownloadService(dio: sl()));

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
  initMarketplaceFeature(sl);
  initContractsFeature(sl);

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
    () => ContractorHomeRemoteDataSourceImpl(
      apiConsumer: sl(),
      projectsRemoteDataSource: sl(),
      bidsRemoteDataSource: sl(),
      profileRemoteDataSource: sl(),
      cacheHelper: sl(),
      secureStorage: sl(),
    ),
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

  // Contractor Projects API Service
  sl.registerLazySingleton<ContractorProjectsRemoteDataSource>(
    () => ContractorProjectsRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );
  sl.registerLazySingleton<ContractorProjectsRepository>(
    () => ContractorProjectsRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetContractorProjectsUseCase(sl()));

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
    () => ContractorProfileRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
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
  sl.registerLazySingleton(() => UpdateContractorProfileUseCase(sl()));
  sl.registerLazySingleton(() => GetContractorReviewsUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => ContractorProfileCubit(
      getContractorProfileUseCase: sl(),
      updateContractorProfileUseCase: sl(),
      getContractorReviewsUseCase: sl(),
      cacheHelper: sl(),
    ),
  );

  //! Contractor Portfolio Feature
  // DataSource
  sl.registerLazySingleton<PortfolioRemoteDataSource>(
    () => PortfolioRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetPortfolioProjectsUseCase(sl()));
  sl.registerLazySingleton(() => AddPortfolioProjectUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePortfolioProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetPortfolioProjectDetailsUseCase(sl()));
  sl.registerLazySingleton(() => DeletePortfolioProjectUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => PortfolioCubit(
      getPortfolioProjectsUseCase: sl(),
      addPortfolioProjectUseCase: sl(),
      updatePortfolioProjectUseCase: sl(),
      getPortfolioProjectDetailsUseCase: sl(),
      deletePortfolioProjectUseCase: sl(),
      cacheHelper: sl(),
    ),
  );

  //! Contractor Bids Feature
  // DataSource
  sl.registerLazySingleton<ContractorBidsRemoteDataSource>(
    () => ContractorBidsRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<ContractorBidsRepository>(
    () => ContractorBidsRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetContractorBidsUseCase(sl()));
  sl.registerLazySingleton(() => GetMyBidsUseCase(sl()));
  sl.registerLazySingleton(() => SubmitBidUseCase(sl()));
  sl.registerLazySingleton(() => CancelBidUseCase(sl()));
  sl.registerLazySingleton(() => GetBidDetailsUseCase(sl()));

  // Cubits
  sl.registerFactory(
    () => ContractorBidsCubit(getContractorBidsUseCase: sl()),
  );
  sl.registerFactory(
    () => MyBidsCubit(
      getMyBidsUseCase: sl(),
      cancelBidUseCase: sl(),
    ),
  );

  //! Contractor Marketplace Feature
  // DataSource
  sl.registerLazySingleton<MarketplaceRemoteDataSource>(
    () => MarketplaceRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<MarketplaceRepository>(
    () => MarketplaceRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetMarketplaceProjectsUseCase(sl()));
  sl.registerLazySingleton(() => GetMarketplaceProjectDetailsUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => MarketplaceCubit(getMarketplaceProjectsUseCase: sl()),
  );

  //! Contractor Contracts Feature
  // DataSource
  sl.registerLazySingleton<ContractsRemoteDataSource>(
    () => ContractsRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<ContractsRepository>(
    () => ContractsRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetContractDetailsUseCase(sl()));
  sl.registerLazySingleton(() => SignContractUseCase(sl()));
  sl.registerLazySingleton(() => GetAcceptedBidContractUseCase(sl()));

  // Cubit
  sl.registerFactory(
    () => ContractCubit(
      getContractDetailsUseCase: sl(),
      signContractUseCase: sl(),
      getAcceptedBidContractUseCase: sl(),
    ),
  );
}
