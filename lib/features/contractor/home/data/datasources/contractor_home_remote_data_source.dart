import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/features/contractor/home/data/mock/contractor_home_mock_data.dart';
import 'package:watad/features/contractor/home/data/models/contractor_home_model.dart';

abstract class ContractorHomeRemoteDataSource {
  Future<ContractorHomeModel> getContractorHomeData({
    required String contractorId,
    String? userName,
  });
}

class ContractorHomeRemoteDataSourceImpl
    implements ContractorHomeRemoteDataSource {
  final ApiConsumer apiConsumer;

  ContractorHomeRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ContractorHomeModel> getContractorHomeData({
    required String contractorId,
    String? userName,
  }) async {
    // Simulating realistic network delay for Shimmer display
    await Future.delayed(const Duration(milliseconds: 900));

    // Uses Mock Data System (Clean Architecture Rule 10 & 11)
    return ContractorHomeMockData.getHomeDataForContractor(
      contractorId: contractorId,
      userName: userName,
    );
  }
}
