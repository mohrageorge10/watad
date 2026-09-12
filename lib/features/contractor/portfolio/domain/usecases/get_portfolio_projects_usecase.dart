import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/domain/repositories/portfolio_repository.dart';

class GetPortfolioProjectsUseCase {
  final PortfolioRepository repository;

  GetPortfolioProjectsUseCase(this.repository);

  Future<ApiResult<List<PortfolioProjectItemModel>>> call({
    required String contractorId,
  }) async {
    return await repository.getPortfolioProjects(
      contractorId: contractorId,
    );
  }
}
