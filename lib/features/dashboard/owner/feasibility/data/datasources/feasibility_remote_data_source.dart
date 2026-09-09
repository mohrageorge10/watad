import 'package:watad/core/errors/error_model.dart';
import 'package:watad/core/errors/exceptions.dart';
import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import 'package:watad/features/dashboard/owner/feasibility/data/models/feasibility_report_model.dart';
import 'package:watad/features/dashboard/owner/feasibility/domain/entities/feasibility_request.dart';

abstract class FeasibilityRemoteDataSource {
  Future<FeasibilityReportModel> calculateFeasibility(FeasibilityRequest request);
  Future<void> saveFeasibility(String reportId, String newProjectTitle);
}

class FeasibilityRemoteDataSourceImpl implements FeasibilityRemoteDataSource {
  final ApiConsumer apiConsumer;

  const FeasibilityRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<FeasibilityReportModel> calculateFeasibility(FeasibilityRequest request) async {
    final response = await apiConsumer.post(
      EndPoints.calculateFeasibility,
      data: {
        "landArea": request.landArea,
        "floorsCount": request.floorsCount,
        "finishingLevel": request.finishingLevel,
        "governorate": request.governorate,
        "city": request.city,
        "latitude": request.latitude,
        "longitude": request.longitude,
      },
    );

    final map = response as Map<String, dynamic>;
    final isSuccess = map['isSuccess'] as bool? ?? false;
    if (!isSuccess) {
      throw ServerException(ErrorModel.fromJson(map));
    }
    
    final data = map['data'] as Map<String, dynamic>? ?? {};
    return FeasibilityReportModel.fromJson(data);
  }

  @override
  Future<void> saveFeasibility(String reportId, String newProjectTitle) async {
    final response = await apiConsumer.post(
      EndPoints.saveFeasibility,
      data: {
        "feasibilityReportId": reportId,
        "newProjectTitle": newProjectTitle,
      },
    );

    final map = response as Map<String, dynamic>;
    final isSuccess = map['isSuccess'] as bool? ?? false;
    if (!isSuccess) {
      throw ServerException(ErrorModel.fromJson(map));
    }
  }
}
