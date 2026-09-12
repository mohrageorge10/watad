import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/portfolio/data/models/portfolio_project_item_model.dart';
import 'package:watad/features/contractor/portfolio/domain/repositories/portfolio_repository.dart';

class AddPortfolioProjectUseCase {
  final PortfolioRepository repository;

  AddPortfolioProjectUseCase(this.repository);

  Future<ApiResult<PortfolioProjectItemModel>> call({
    required Map<String, dynamic> projectData,
  }) {
    return repository.addPortfolioProject(projectData: projectData);
  }
}
