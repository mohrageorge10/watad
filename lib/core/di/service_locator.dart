import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/dio_consumer.dart';
import 'package:watad/core/network/connection/network_info.dart';
import 'package:watad/core/services/file_download_service.dart';
import 'package:watad/features/auth/auth_injection.dart';
import 'package:watad/features/contractor/bids/contractor_bids_injection.dart';
import 'package:watad/features/contractor/contracts/contractor_contracts_injection.dart';
import 'package:watad/features/contractor/daily_logs/contractor_daily_logs_injection.dart';
import 'package:watad/features/contractor/home/contractor_home_injection.dart';
import 'package:watad/features/contractor/marketplace/contractor_marketplace_injection.dart';
import 'package:watad/features/contractor/milestone_inspection/contractor_milestone_inspection_injection.dart';
import 'package:watad/features/contractor/milestone_logs/contractor_milestone_logs_injection.dart';
import 'package:watad/features/contractor/portfolio/contractor_portfolio_injection.dart';
import 'package:watad/features/contractor/profile/contractor_profile_injection.dart';
import 'package:watad/features/contractor/project_dashboard/contractor_project_dashboard_injection.dart';
import 'package:watad/features/dashboard/owner/contracts/contracts_injection.dart';
import 'package:watad/features/dashboard/owner/feasibility/feasibility_injection.dart';
import 'package:watad/features/dashboard/owner/home/home_injection.dart';
import 'package:watad/features/dashboard/owner/marketplace/marketplace_injection.dart';
import 'package:watad/features/dashboard/owner/projects/create_project/create_project_injection.dart';

final GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  //! Core / External
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  sl.registerLazySingleton<FileDownloadService>(() => FileDownloadService(dio: sl()));

  //! Cache & Storage
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
  sl.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper());

  //! Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(
      dio: sl(),
      cacheHelper: sl(),
      secureStorage: sl(),
    ),
  );

  //! Auth Feature
  initAuthFeature(sl);

  //! Owner Features
  initHomeFeature(sl);
  initFeasibilityFeature(sl);
  initCreateProjectFeature(sl);
  initMarketplaceFeature(sl);
  initContractsFeature(sl);

  //! Contractor Features
  initContractorHomeFeature(sl);
  initContractorProjectDashboardFeature(sl);
  initContractorDailyLogsFeature(sl);
  initContractorMilestoneLogsFeature(sl);
  initContractorMilestoneInspectionFeature(sl);
  initContractorProfileFeature(sl);
  initContractorPortfolioFeature(sl);
  initContractorBidsFeature(sl);
  initContractorMarketplaceFeature(sl);
  initContractorContractsFeature(sl);
}
