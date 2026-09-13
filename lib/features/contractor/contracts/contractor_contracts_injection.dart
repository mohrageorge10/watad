import 'package:get_it/get_it.dart';
import 'package:watad/features/contractor/contracts/data/datasources/contracts_remote_data_source.dart';
import 'package:watad/features/contractor/contracts/data/repositories/contracts_repository_impl.dart';
import 'package:watad/features/contractor/contracts/domain/repositories/contracts_repository.dart';
import 'package:watad/features/contractor/contracts/domain/usecases/get_accepted_bid_contract_usecase.dart';
import 'package:watad/features/contractor/contracts/domain/usecases/get_contract_details_usecase.dart';
import 'package:watad/features/contractor/contracts/domain/usecases/sign_contract_usecase.dart';
import 'package:watad/features/contractor/contracts/presentation/cubit/contract_cubit.dart';

void initContractorContractsFeature(GetIt sl) {
  //! DataSource
  sl.registerLazySingleton<ContractsRemoteDataSource>(
    () => ContractsRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  //! Repository
  sl.registerLazySingleton<ContractsRepository>(
    () => ContractsRepositoryImpl(remoteDataSource: sl()),
  );

  //! UseCases
  sl.registerLazySingleton(() => GetContractDetailsUseCase(sl()));
  sl.registerLazySingleton(() => SignContractUseCase(sl()));
  sl.registerLazySingleton(() => GetAcceptedBidContractUseCase(sl()));

  //! Cubit
  sl.registerFactory(
    () => ContractCubit(
      getContractDetailsUseCase: sl(),
      signContractUseCase: sl(),
      getAcceptedBidContractUseCase: sl(),
    ),
  );
}
