import 'package:watad/core/errors/error_model.dart';
import 'package:watad/core/errors/exceptions.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/features/dashboard/owner/project_dashboard/change_orders/data/models/pending_change_order_dto.dart';

abstract class AllChangeOrdersRemoteDataSource {
  Future<List<PendingChangeOrderDto>> getPendingChangeOrders(String projectId);
}

class AllChangeOrdersRemoteDataSourceImpl implements AllChangeOrdersRemoteDataSource {
  final ApiConsumer apiConsumer;

  AllChangeOrdersRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<PendingChangeOrderDto>> getPendingChangeOrders(String projectId) async {
    final response = await apiConsumer.get(EndPoints.pendingChangeOrders(projectId));
    final map = response as Map<String, dynamic>;
    final isSuccess = map['isSuccess'] as bool? ?? false;

    if (!isSuccess) {
      throw ServerException(ErrorModel.fromJson(map));
    }

    final data = map['data'];
    if (data == null) {
      return [];
    }

    if (data is List) {
      return data.map((e) => PendingChangeOrderDto.fromJson(e as Map<String, dynamic>)).toList();
    }

    return [];
  }
}
