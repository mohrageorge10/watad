import 'package:watad/core/network/api/api_consumer.dart';
import 'package:watad/features/contractor/portfolio/data/mock/portfolio_projects_mock_data.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';

abstract class PortfolioRemoteDataSource {
  Future<List<PortfolioProjectItemModel>> getPortfolioProjects({
    required String contractorId,
  });
}

class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final ApiConsumer apiConsumer;

  PortfolioRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<PortfolioProjectItemModel>> getPortfolioProjects({
    required String contractorId,
  }) async {
    // Simulating network latency for shimmer display (Clean Architecture Rules 10 & 11)
    await Future.delayed(const Duration(milliseconds: 700));

    // When backend endpoint is ready, simply uncomment:
    // final response = await apiConsumer.get('${EndPoints.portfolioProjects}/$contractorId');
    // return (response['data'] as List)
    //     .map((item) => PortfolioProjectItemModel.fromJson(item))
    //     .toList();

    return PortfolioProjectsMockData.projects;
  }
}
