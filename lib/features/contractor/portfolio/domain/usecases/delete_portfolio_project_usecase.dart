import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/contractor/portfolio/domain/repositories/portfolio_repository.dart';

class DeletePortfolioProjectUseCase {
  final PortfolioRepository repository;

  DeletePortfolioProjectUseCase(this.repository);

  Future<ApiResult<bool>> call({
    required String projectId,
  }) {
    return repository.deletePortfolioProject(projectId: projectId);
  }
}
