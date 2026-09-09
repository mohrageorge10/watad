import 'package:get_it/get_it.dart';
import 'data/datasources/contracts_remote_data_source.dart';
import 'data/repositories/contracts_repository_impl.dart';
import 'domain/repositories/contracts_repository.dart';
import 'domain/usecases/create_contract_usecase.dart';
import 'domain/usecases/get_contract_details_usecase.dart';
import 'domain/usecases/generate_contract_pdf_usecase.dart';
import 'presentation/cubit/create_contract_cubit.dart';
import 'presentation/cubit/contract_details_cubit.dart';
// Note: GetBidDetailsUseCase is already registered in marketplace feature, so we can just use sl()

void initContractsFeature(GetIt sl) {
  // DataSource
  sl.registerLazySingleton<ContractsRemoteDataSource>(
    () => ContractsRemoteDataSourceImpl(apiConsumer: sl()),
  );

  // Repository
  sl.registerLazySingleton<ContractsRepository>(
    () => ContractsRepositoryImpl(remoteDataSource: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => CreateContractUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetContractDetailsUseCase(repository: sl()));
  sl.registerLazySingleton(() => GenerateContractPdfUseCase(repository: sl()));

  // Cubits
  sl.registerFactory(() => CreateContractCubit(
        createContractUseCase: sl(),
        getBidDetailsUseCase: sl(),
      ));
  sl.registerFactory(() => ContractDetailsCubit(
        getContractDetailsUseCase: sl(),
        generateContractPdfUseCase: sl(),
        fileDownloadService: sl(),
      ));
}
