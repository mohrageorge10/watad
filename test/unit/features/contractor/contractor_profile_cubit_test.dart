import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/profile/data/mock/contractor_profile_mock_data.dart';
import 'package:watad/features/contractor/profile/domain/repositories/contractor_profile_repository.dart';
import 'package:watad/features/contractor/profile/domain/usecases/get_contractor_profile_usecase.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_cubit.dart';
import 'package:watad/features/contractor/profile/presentation/cubit/contractor_profile_state.dart';

class MockContractorProfileRepository extends Mock
    implements ContractorProfileRepository {}

class MockCacheHelper extends Mock implements CacheHelper {}

void main() {
  late ContractorProfileCubit cubit;
  late MockContractorProfileRepository mockRepository;
  late MockCacheHelper mockCacheHelper;
  late GetContractorProfileUseCase useCase;

  setUp(() {
    mockRepository = MockContractorProfileRepository();
    mockCacheHelper = MockCacheHelper();
    useCase = GetContractorProfileUseCase(mockRepository);
    cubit = ContractorProfileCubit(
      getContractorProfileUseCase: useCase,
      cacheHelper: mockCacheHelper,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('ContractorProfileCubit', () {
    test('initial state is ContractorProfileInitial', () {
      expect(cubit.state, isA<ContractorProfileInitial>());
    });

    test('emits [Loading, Success] when profile data is loaded successfully',
        () async {
      final mockProfile = ContractorProfileMockData.getContractorProfile(
        contractorId: 'test_contractor_1',
      );

      when(() => mockCacheHelper.getData(key: any(named: 'key')))
          .thenReturn(null);
      when(() => mockRepository.getContractorProfile(
              contractorId: any(named: 'contractorId')))
          .thenAnswer((_) async => ApiResult.success(mockProfile));

      final expectedStates = [
        isA<ContractorProfileLoading>(),
        isA<ContractorProfileSuccess>().having(
          (s) => s.profile.name,
          'contractor name',
          'Ahmed Khaled Hassan',
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      await cubit.loadProfile();
    });

    test('selectTab changes selectedTabIndex in state', () async {
      final mockProfile = ContractorProfileMockData.getContractorProfile(
        contractorId: 'test_contractor_1',
      );

      when(() => mockCacheHelper.getData(key: any(named: 'key')))
          .thenReturn(null);
      when(() => mockRepository.getContractorProfile(
              contractorId: any(named: 'contractorId')))
          .thenAnswer((_) async => ApiResult.success(mockProfile));

      await cubit.loadProfile();

      expect((cubit.state as ContractorProfileSuccess).selectedTabIndex, 0);

      cubit.selectTab(1);
      expect((cubit.state as ContractorProfileSuccess).selectedTabIndex, 1);
    });
  });
}
