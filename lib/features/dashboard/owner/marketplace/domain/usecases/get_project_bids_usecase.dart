import 'package:watad/core/network/api/api_result.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/entities/project_bid.dart';
import 'package:watad/features/dashboard/owner/marketplace/domain/repositories/marketplace_repository.dart';

class GetProjectBidsParams {
  final String projectId;
  final String? sortBy;
  final double? maxCost;
  final int? maxDurationDays;

  GetProjectBidsParams({
    required this.projectId,
    this.sortBy,
    this.maxCost,
    this.maxDurationDays,
  });
}

class GetProjectBidsUseCase {
  final MarketplaceRepository repository;

  GetProjectBidsUseCase(this.repository);

  Future<ApiResult<List<ProjectBid>>> call(GetProjectBidsParams params) {
    return repository.getProjectBids(
      projectId: params.projectId,
      sortBy: params.sortBy,
      maxCost: params.maxCost,
      maxDurationDays: params.maxDurationDays,
    );
  }
}
