import 'package:watad/core/errors/error_model.dart';
import 'package:watad/core/errors/exceptions.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/features/dashboard/owner/alerts/data/models/paginated_notifications_model.dart';

abstract class AlertsRemoteDataSource {
  Future<PaginatedNotificationsModel> getNotifications({
    required int pageNumber,
    required int pageSize,
    String? category,
    String? type,
  });
}

class AlertsRemoteDataSourceImpl implements AlertsRemoteDataSource {
  final ApiConsumer apiConsumer;

  const AlertsRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<PaginatedNotificationsModel> getNotifications({
    required int pageNumber,
    required int pageSize,
    String? category,
    String? type,
  }) async {
    final response = await apiConsumer.get(
      EndPoints.notifications,
      queryParameters: {
        'PageNumber': pageNumber,
        'PageSize': pageSize,
        if (category != null && category.isNotEmpty) 'Category': category,
        if (type != null && type.isNotEmpty) 'Type': type,
      },
    );

    final map = response as Map<String, dynamic>;
    final isSuccess = map['isSuccess'] as bool? ?? false;
    
    if (!isSuccess) {
      throw ServerException(ErrorModel.fromJson(map));
    }

    final data = map['data'];
    if (data == null) {
      return const PaginatedNotificationsModel(
        items: [], currentPage: 1, totalPages: 1, pageSize: 0, totalCount: 0, hasPrevious: false, hasNext: false,
      );
    }
    
    return PaginatedNotificationsModel.fromJson(data as Map<String, dynamic>);
  }
}
