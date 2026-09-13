import 'package:get_it/get_it.dart';
import 'package:watad/features/contractor/milestone_inspection/data/datasources/milestone_inspection_remote_data_source.dart';
import 'package:watad/features/contractor/milestone_inspection/data/repositories/milestone_inspection_repository_impl.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/repositories/milestone_inspection_repository.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/usecases/get_milestone_inspection_details_usecase.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/usecases/submit_milestone_inspection_request_usecase.dart';
import 'package:watad/features/contractor/milestone_inspection/presentation/cubit/milestone_inspection_cubit.dart';

void initContractorMilestoneInspectionFeature(GetIt sl) {
  sl.registerLazySingleton<MilestoneInspectionRemoteDataSource>(
    () => MilestoneInspectionRemoteDataSourceImpl(
      apiConsumer: sl(),
      secureStorage: sl(),
      cacheHelper: sl(),
    ),
  );

  sl.registerLazySingleton<MilestoneInspectionRepository>(
    () => MilestoneInspectionRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(
    () => GetMilestoneInspectionDetailsUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => SubmitMilestoneInspectionRequestUseCase(sl()),
  );

  sl.registerFactory(
    () => MilestoneInspectionCubit(
      getMilestoneInspectionDetailsUseCase: sl(),
      submitMilestoneInspectionRequestUseCase: sl(),
    ),
  );
}
