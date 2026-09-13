import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/core/network/api/end_points.dart';
import '../models/financial_overview_response_model.dart';

abstract class FinancialSummaryRemoteDataSource {
  Future<FinancialOverviewResponseModel> getFinancialOverview(String projectId);
}

class FinancialSummaryRemoteDataSourceImpl
    implements FinancialSummaryRemoteDataSource {
  final ApiConsumer apiConsumer;

  const FinancialSummaryRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<FinancialOverviewResponseModel> getFinancialOverview(
      String projectId) async {
    final response =
        await apiConsumer.get(EndPoints.financialOverview(projectId));
    return FinancialOverviewResponseModel.fromJson(
        response as Map<String, dynamic>);
  }
}
