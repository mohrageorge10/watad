import 'package:get_it/get_it.dart';
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

void initContractorBidsFeature(GetIt sl) {
  //! DataSource
  sl.registerLazySingleton<ContractorBidsRemoteDataSource>(
    () => ContractorBidsRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  //! Repository
  sl.registerLazySingleton<ContractorBidsRepository>(
    () => ContractorBidsRepositoryImpl(remoteDataSource: sl()),
  );

  //! UseCases
  sl.registerLazySingleton(() => GetContractorBidsUseCase(sl()));
  sl.registerLazySingleton(() => GetMyBidsUseCase(sl()));
  sl.registerLazySingleton(() => SubmitBidUseCase(sl()));
  sl.registerLazySingleton(() => CancelBidUseCase(sl()));
  sl.registerLazySingleton(() => GetBidDetailsUseCase(sl()));

  //! Cubits
  sl.registerFactory(
    () => ContractorBidsCubit(getContractorBidsUseCase: sl()),
  );
  sl.registerFactory(
    () => MyBidsCubit(
      getMyBidsUseCase: sl(),
      cancelBidUseCase: sl(),
    ),
  );
}
