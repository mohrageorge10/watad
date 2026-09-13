import 'package:get_it/get_it.dart';
import 'package:watad/features/contractor/milestone_logs/data/datasources/milestone_logs_remote_data_source.dart';
import 'package:watad/features/contractor/milestone_logs/data/repositories/milestone_logs_repository_impl.dart';
import 'package:watad/features/contractor/milestone_logs/domain/repositories/milestone_logs_repository.dart';
import 'package:watad/features/contractor/milestone_logs/domain/usecases/get_milestone_logs_usecase.dart';
import 'package:watad/features/contractor/milestone_logs/domain/usecases/request_milestone_inspection_usecase.dart';
import 'package:watad/features/contractor/milestone_logs/presentation/cubit/milestone_logs_cubit.dart';

void initContractorMilestoneLogsFeature(GetIt sl) {
  sl.registerLazySingleton<MilestoneLogsRemoteDataSource>(
    () => MilestoneLogsRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  sl.registerLazySingleton<MilestoneLogsRepository>(
    () => MilestoneLogsRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(
    () => GetMilestoneLogsUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => RequestMilestoneInspectionUseCase(sl()),
  );

  sl.registerFactory(
    () => MilestoneLogsCubit(
      getMilestoneLogsUseCase: sl(),
      requestMilestoneInspectionUseCase: sl(),
    ),
  );
}
