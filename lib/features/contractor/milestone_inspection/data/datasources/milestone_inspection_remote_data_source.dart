import 'package:watad/core/cache/cache_helper.dart';
import 'package:watad/core/cache/secure_storage_helper.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/core/utils/cache_keys.dart';
import 'package:watad/features/contractor/milestone_inspection/data/models/milestone_inspection_details_model.dart';
import 'package:watad/features/contractor/milestone_inspection/domain/entities/milestone_inspection_details_entity.dart';

abstract class MilestoneInspectionRemoteDataSource {
  Future<MilestoneInspectionDetailsEntity> getMilestoneInspectionDetails(String milestoneId);
  Future<bool> submitMilestoneInspectionRequest({
    required String milestoneId,
    String? notes,
  });
}

class MilestoneInspectionRemoteDataSourceImpl implements MilestoneInspectionRemoteDataSource {
  final ApiConsumer apiConsumer;
  final SecureStorageHelper secureStorage;
  final CacheHelper cacheHelper;

  MilestoneInspectionRemoteDataSourceImpl({
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
  Future<MilestoneInspectionDetailsEntity> getMilestoneInspectionDetails(String milestoneId) async {
    final headers = await _getAuthHeaders();
    final response = await apiConsumer.get(
      EndPoints.milestoneDetails(milestoneId),
      headers: headers.isNotEmpty ? headers : null,
    );

    if (response != null && response is Map<String, dynamic>) {
      final data = response[ApiKey.data] ?? response;
      if (data is Map<String, dynamic> && data.isNotEmpty) {
        return MilestoneInspectionDetailsModel.fromJson(data);
      }
    }

    throw const FormatException('Milestone inspection details not found');
  }

  @override
  Future<bool> submitMilestoneInspectionRequest({
    required String milestoneId,
    String? notes,
  }) async {
    final headers = await _getAuthHeaders();
    final response = await apiConsumer.post(
      EndPoints.requestMilestoneInspection(milestoneId),
      data: {
        if (notes != null && notes.isNotEmpty) ApiKey.notes: notes,
      },
      headers: headers.isNotEmpty ? headers : null,
    );

    if (response != null && response is Map<String, dynamic>) {
      if (response[ApiKey.isSuccess] == false) {
        return false;
      }
      return true;
    }

    return response != null;
  }
}
