import 'package:flutter_test/flutter_test.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/home/data/mock/contractor_home_mock_data.dart';
import 'package:watad/features/contractor/home/domain/repositories/contractor_home_repository.dart';
import 'package:watad/features/contractor/home/domain/usecases/get_contractor_home_data_usecase.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_home_cubit.dart';
import 'package:watad/features/contractor/home/presentation/cubit/contractor_home_state.dart';
import 'package:mocktail/mocktail.dart';

class MockContractorHomeRepository extends Mock
    implements ContractorHomeRepository {}

class MockCacheHelper extends Mock implements CacheHelper {}

void main() {
  late ContractorHomeCubit cubit;
  late MockContractorHomeRepository mockRepository;
  late MockCacheHelper mockCacheHelper;
  late GetContractorHomeDataUseCase useCase;

  setUp(() {
    mockRepository = MockContractorHomeRepository();
    mockCacheHelper = MockCacheHelper();
    useCase = GetContractorHomeDataUseCase(mockRepository);
    cubit = ContractorHomeCubit(
      getContractorHomeDataUseCase: useCase,
      cacheHelper: mockCacheHelper,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('ContractorHomeCubit', () {
    test('initial state is ContractorHomeInitial', () {
      expect(cubit.state, isA<ContractorHomeInitial>());
    });

    test('emits [Loading, Success] when data has active projects', () async {
      final populatedData = ContractorHomeMockData.getPopulatedHomeData();

      when(() => mockCacheHelper.getData(key: any(named: 'key')))
          .thenReturn('test_contractor_id');
      when(() => mockRepository.getContractorHomeData(
              contractorId: any(named: 'contractorId')))
          .thenAnswer((_) async => ApiResult.success(populatedData));

      final expectedStates = [
        isA<ContractorHomeLoading>(),
        isA<ContractorHomeSuccess>().having(
          (s) => s.homeData.activeProjects.length,
          'active projects count',
          3,
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadHomeData();
    });

    test('emits [Loading, Empty] when new contractor has 0 projects and 0 bids',
        () async {
      final emptyData = ContractorHomeMockData.getEmptyHomeData();

      when(() => mockCacheHelper.getData(key: any(named: 'key')))
          .thenReturn('new_contractor_123');
      when(() => mockRepository.getContractorHomeData(
              contractorId: any(named: 'contractorId')))
          .thenAnswer((_) async => ApiResult.success(emptyData));

      final expectedStates = [
        isA<ContractorHomeLoading>(),
        isA<ContractorHomeEmpty>().having(
          (s) => s.homeData.isEmptyState,
          'is empty state',
          true,
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadHomeData();
    });
  });
}
