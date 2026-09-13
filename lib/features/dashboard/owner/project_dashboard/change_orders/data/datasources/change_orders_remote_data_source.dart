import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import '../models/change_orders_history_response_model.dart';
import '../models/pending_change_order_dto.dart';

abstract class ChangeOrdersRemoteDataSource {
  Future<ChangeOrdersHistoryResponseModel> getChangeOrdersHistory(String projectId);
  Future<PendingChangeOrderDto> getChangeOrderDetails(String id);
  Future<bool> decideChangeOrder(String id, bool isApproved, String? rejectionReason);
  Future<String> createChangeOrder(String projectId, String description, num costImpact, int timeImpactDays);
}

class ChangeOrdersRemoteDataSourceImpl implements ChangeOrdersRemoteDataSource {
  final ApiConsumer apiConsumer;

  const ChangeOrdersRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ChangeOrdersHistoryResponseModel> getChangeOrdersHistory(String projectId) async {
    final response = await apiConsumer.get(EndPoints.changeOrdersHistory(projectId));
    return ChangeOrdersHistoryResponseModel.fromJson(response as Map<String, dynamic>);
  }

  @override
  Future<PendingChangeOrderDto> getChangeOrderDetails(String id) async {
    final response = await apiConsumer.get(EndPoints.changeOrderDetails(id));
    return PendingChangeOrderDto.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<bool> decideChangeOrder(String id, bool isApproved, String? rejectionReason) async {
    final body = {
      "isApproved": isApproved,
      if (!isApproved && rejectionReason != null) "rejectionReason": rejectionReason,
    };
    final response = await apiConsumer.put(EndPoints.decideChangeOrder(id), data: body);
    return response['data'] == true;
  }

  @override
  Future<String> createChangeOrder(String projectId, String description, num costImpact, int timeImpactDays) async {
    final body = {
      "projectId": projectId,
      "description": description,
      "costImpact": costImpact,
      "timeImpactDays": timeImpactDays,
    };
    final response = await apiConsumer.post(EndPoints.changeOrders, data: body);
    return response['data'] as String;
  }
}
