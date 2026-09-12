import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/contracts/data/models/contract_model.dart';

abstract class ContractsRemoteDataSource {
  Future<ContractModel> getContractDetails(String contractId);
  Future<bool> signContract(String contractId, {String? digitalSignature});
  Future<ContractModel?> getAcceptedBidContract(String bidId);
}

class ContractsRemoteDataSourceImpl implements ContractsRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  ContractsRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.secureStorage,
    required this.cacheHelper,
  });

  Future<Map<String, dynamic>> _getAuthHeaders() async {
    final token = await secureStorage.read(key: CacheKeys.token) ??
        (cacheHelper.getData(key: CacheKeys.token) as String?);

    return <String, dynamic>{
      if (token != null && token.isNotEmpty)
        ApiKey.authorization: ApiKey.bearer(token),
    };
  }

  @override
  Future<ContractModel> getContractDetails(String contractId) async {
    final headers = await _getAuthHeaders();
    final response = await apiConsumer.get(
      EndPoints.contractDetails(contractId),
      headers: headers.isNotEmpty ? headers : null,
    );

    Map<String, dynamic>? data;
    if (response is Map<String, dynamic>) {
      if (response.containsKey(ApiKey.data) &&
          response[ApiKey.data] is Map<String, dynamic>) {
        data = response[ApiKey.data] as Map<String, dynamic>;
      } else {
        data = response;
      }
    }

    if (data != null && data.isNotEmpty) {
      return ContractModel.fromJson(data);
    }

    throw const FormatException('Contract data not found');
  }

  @override
  Future<bool> signContract(
    String contractId, {
    String? digitalSignature,
  }) async {
    final headers = await _getAuthHeaders();
    final body = <String, dynamic>{
      'ContractId': contractId,
      'DigitalSignature': digitalSignature ?? 'digital_sign_hash_contractor',
      'SignedAt': DateTime.now().toIso8601String(),
    };

    final response = await apiConsumer.post(
      EndPoints.signContract(contractId),
      data: body,
      headers: headers.isNotEmpty ? headers : null,
    );

    if (response is Map<String, dynamic>) {
      return response[ApiKey.isSuccess] == true ||
          response['statusCode'] == 200 ||
          response['statusCode'] == 201 ||
          response['status'] == 'success';
    }
    return true;
  }

  @override
  Future<ContractModel?> getAcceptedBidContract(String bidId) async {
    final headers = await _getAuthHeaders();
    final response = await apiConsumer.get(
      EndPoints.acceptedBidContract(bidId),
      headers: headers.isNotEmpty ? headers : null,
    );

    Map<String, dynamic>? data;
    if (response is Map<String, dynamic>) {
      if (response.containsKey(ApiKey.data) &&
          response[ApiKey.data] is Map<String, dynamic>) {
        data = response[ApiKey.data] as Map<String, dynamic>;
      } else {
        data = response;
      }
    }

    if (data != null && data.isNotEmpty) {
      return ContractModel.fromJson(data);
    }

    return null;
  }
}
