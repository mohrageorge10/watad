import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/home/data/models/contractor_bid_model.dart';

abstract class ContractorBidsRemoteDataSource {
  Future<List<ContractorBidModel>> fetchContractorBids({
    int pageNumber = 1,
    int pageSize = 10,
  });
}

class ContractorBidsRemoteDataSourceImpl
    implements ContractorBidsRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  ContractorBidsRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.secureStorage,
    required this.cacheHelper,
  });

  @override
  Future<List<ContractorBidModel>> fetchContractorBids({
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    // 1. Retrieve token securely without hardcoding
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    // 2. Prepare headers with Bearer token using centralized constants
    final headers = <String, dynamic>{
      if (token != null && token.isNotEmpty)
        ApiKey.authorization: ApiKey.bearer(token),
    };

    // 3. Centralized Query Parameters (No hardcoding)
    final queryParameters = <String, dynamic>{
      ApiQueryParams.pageNumber: pageNumber,
      ApiQueryParams.pageSize: pageSize,
    };

    // 4. API Request
    final response = await apiConsumer.get(
      EndPoints.contractorBids,
      queryParameters: queryParameters,
      headers: headers,
    );

    // 5. Safe and flexible parsing
    if (response is List) {
      return response
          .map((item) =>
              ContractorBidModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is Map<String, dynamic>) {
      final dynamic data = response[ApiKey.data] ?? response['items'] ?? response['bids'];
      if (data is List) {
        return data
            .map((item) =>
                ContractorBidModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    }

    return const [];
  }
}
