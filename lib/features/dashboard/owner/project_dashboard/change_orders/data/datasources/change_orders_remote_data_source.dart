import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import '../models/change_orders_history_response_model.dart';

abstract class ChangeOrdersRemoteDataSource {
  Future<ChangeOrdersHistoryResponseModel> getChangeOrdersHistory(String projectId);
}

class ChangeOrdersRemoteDataSourceImpl implements ChangeOrdersRemoteDataSource {
  final ApiConsumer apiConsumer;

  const ChangeOrdersRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ChangeOrdersHistoryResponseModel> getChangeOrdersHistory(String projectId) async {
    final response = await apiConsumer.get(EndPoints.changeOrdersHistory(projectId));
    return ChangeOrdersHistoryResponseModel.fromJson(response as Map<String, dynamic>);
  }
}
