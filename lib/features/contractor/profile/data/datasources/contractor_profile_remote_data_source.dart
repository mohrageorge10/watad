import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/features/contractor/profile/data/mock/contractor_profile_mock_data.dart';
import 'package:watad/features/contractor/profile/data/models/contractor_profile_model.dart';

abstract class ContractorProfileRemoteDataSource {
  Future<ContractorProfileModel> getContractorProfile({
    required String contractorId,
    String? userName,
  });
}

class ContractorProfileRemoteDataSourceImpl
    implements ContractorProfileRemoteDataSource {
  final ApiConsumer apiConsumer;

  ContractorProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ContractorProfileModel> getContractorProfile({
    required String contractorId,
    String? userName,
  }) async {
    // Simulating realistic network delay to demonstrate Shimmer Loading UI
    await Future.delayed(const Duration(milliseconds: 800));

    return ContractorProfileMockData.getContractorProfile(
      contractorId: contractorId,
      userName: userName,
    );
  }
}
