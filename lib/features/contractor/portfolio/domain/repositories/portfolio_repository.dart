import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';

abstract class PortfolioRepository {
  Future<ApiResult<List<PortfolioProjectItemModel>>> getPortfolioProjects({
    required String contractorId,
  });

  Future<ApiResult<List<PortfolioItemModel>>> fetchContractorPortfolio();
}
