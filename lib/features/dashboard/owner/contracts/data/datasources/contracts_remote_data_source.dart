import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import '../models/contract_details_dto.dart';
import '../models/create_contract_request_dto.dart';

abstract class ContractsRemoteDataSource {
  Future<String> createContract(CreateContractRequestDto request);
  Future<ContractDetailsDto> getContractDetails(String id);
  Future<String> generateContractPdf(String projectId, String contractId);
}

class ContractsRemoteDataSourceImpl implements ContractsRemoteDataSource {
  final ApiConsumer apiConsumer;

  ContractsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<String> createContract(CreateContractRequestDto request) async {
    final response = await apiConsumer.post(
      EndPoints.createContract,
      data: request.toJson(),
    );
    // Assuming the response follows ApiResult format where 'data' holds the ID
    return response[ApiKey.data];
  }

  @override
  Future<ContractDetailsDto> getContractDetails(String id) async {
    final response = await apiConsumer.get(
      EndPoints.contractDetails(id),
    );
    return ContractDetailsDto.fromJson(response[ApiKey.data]);
  }

  @override
  Future<String> generateContractPdf(String projectId, String contractId) async {
    final response = await apiConsumer.post(
      EndPoints.generateContractPdf(projectId, contractId),
    );
    return response[ApiKey.data]['pdfUrl'];
  }
}
